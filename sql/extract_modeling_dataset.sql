/*
Goal:
Produce a single modeling dataset table at the listing level that includes:
- Listing attributes (price, length, year, boat_type, condition, dealer_type, seller_rating)
- Aggregated 7-day engagement signals (views_7d, saves_7d, inquiries_7d)
- Listing quality (num_photos)
- Freshness (days_on_site)
*/

WITH base_listings AS (
  SELECT
  1.listing_id,
  1.price,
  1.length_ft,
  1.year,
  1.boat_type,
  1.condition,
  1.dealer_type,
  1.seller_rating,
  1.created_date
FROM listings 1
),

engagment_7d AS (
  SELECT
  e.listing_id,
  SUM(CASE WHEN e.event_type = 'view' THEN 1 ELSE 0 END) AS views_7d,
  SUM(CASE WHEN e.event_type = 'save' THEN 1 ELSE 0 END) AS saves_7d,
  SUM(CASE WHEN e.event_type = 'inquiry' THEN 1 ELSE 0 END) AS inquiries_7d
FROM engagement_events e
WHERE e.event_date >= DATEADD(day, -7, CURRENT_DATE)
GROUP BY e.listing_id
),

photo_counts  AS (
  SELECT
      p.listing_id,
      COUNT(*) AS num_photos p
  FROM listing_photos p
  GROUP BY p.listing_id
),

labels AS (
  SELECT
    listing_id,
    CASE WHEN inquiries_7d >= 1 THEN 1 ELSE 0 END AS conversion
    FROM engagement_7d
)

SELECT
  b1.listing_id,
  b1.price,
  b1.length_ft,
  b1.year,
  b1.boat_type,
  b1.condition,
  b1.dealer_type,
  b1.seller_rating,

DATEDIFF(day, b1.created_date, CURRENT_DATE) AS days_on_site,

COALESCE(e.views_7d, 0) AS views_7d,
COALESCE(e.saves_7d, 0) AS saves_7d,
COALESCE(e.inquiries_7d, 0) AS inquiries_7d

COALESCE(pc.num_photos, 0) AS num_photos,
COALESCE(lb.conversion, 0) AS conversion

FROM base_listings b1
LEFT JOIN engagement_7d e
  ON b1.listing_id = e.listing_id
LEFT JOIN photo_counts pc
  ON b1.listing_id = pc.listing_id
LEFT JOIN labels lb
  ON b1.listing_id = lb.lisitng_id;
