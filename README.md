# Pattern-Classification

![Protein Lysine Methylation](https://upload.wikimedia.org/wikipedia/commons/1/1d/Methylation-lysine.PNG)

## Data Exploration Highlights (Descriptors_Training)

1. Outliers present 
2. Dataset is highly skewed.
3. Class imbalance. 1:17
4. High multicolinearity in the data
5. No Missing Data

## Data Exploration Highlights (Descriptors_Calibration)

1. Outliers present 
2. Dataset is highly skewed.
3. Class imbalance. 1:20
4. High multicolinearity in the data
5. No Missing Data


## Data Modelling

1. No preprocess model - ***Precision: [0.94392149 0.33333333] Recall: [0.99957582 0.00355872]***
2. No preprocess model without outliers - ***Precision: [0.94919116 0.        ] Recall: [0.99832255 0.        ]***
3. Prep (Norm & SMOTE & RandomUnderSampling) - ***Precision: [0.94743509 0.12355212] Recall: [0.95185578 0.113879  ]***
4. Prep (--||--) without outliers - ***Precision: [0.95104895 0.08032129] Recall: [0.94512341 0.0896861 ]***


***P.S - Removing outliers reduces the accurace if the model, Class imbalance has an impact on model***
