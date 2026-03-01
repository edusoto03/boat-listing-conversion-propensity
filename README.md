# 🛥 Boat Listing Conversion Propensity Model

***Overview***

This project simulates an internal machine learning workflow for predicitng the probability that a boat listing generates a lead (conversion) in a marine markeplace.

The objective of this model is to demonstrate applied data science skills aligned with marketplace analytics, this includes:
- SQL-based dataset construction
- Feature engineering
- Propensity modeling (logistic regression)
- Model evaluation and tradeoff analysis
- Business-driven interpretation

***Problem Definition***

Predict the likelihood that a listing will generate at least one inquiry within a 7-day window.

This allows for:
- Listing ranking
- Sales prioritization
- Pricing review triggers
- Inventory performance monitoring

***Dataset Construction (SQL Layer)***

The modeling dataset is constructed from normalized tables:
- listings
- engagement_events
- listing_photos

The SQL layer aggregates engagement into 7-day metrics and produces a listing-level dataset.

***Feature Engineering Highlights***
- Boat age (year -> age transformation)
- Price per foot (relative value metric)
- Engagement rate (saves + inquiries/views)
- Dealer indicator
- Log-transformed days on site
- One-hot encoded categorical variables

***Model Approach***
- Logistic Regression (interpretable baseline)
- Sklearn pipeline with preprocessing
- Stratified train/test split
- Evaluated using ROC-AUC,precision, recall and F1

***Key Insights***
- Engagement intensity is the strongest predictor of conversion.
- Seller reputation and dealer affiliation increase conversion likelihood.
- Listings with prolonged time on site underperform.
- Certain boat types exhibit stronger baseline demand.

***Operational Applications***
- Rank listings by predicted probability
- Prioritize top decile for sales outreach
- Flag stale inventory for pricing inventory
- Use engagement metrics as early performance indicators

***Limitations***
- Synthetic data used for demonstration
- Potential temporary leakage depending on prediction timing
- Logistic regression assumes linear log-odds relationship

***Repository Structure***
/notebooks -> End-to-end modeling workflow
/sql -> Warehouse-style dataset extraction
