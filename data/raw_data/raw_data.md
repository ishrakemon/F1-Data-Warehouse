F1_Data_Engineering/
│
├── data/                         
│   ├── raw/                       
│   │   ├── circuits.csv
│   │   ├── drivers.csv
│   │   ├── races.csv
│   │   ├── results.csv
│   │   └── ... (all other files)
│   └── processed/                 
│
├── src/                           
│   ├── sql/                       
│   │   ├── schema_setup.sql    
│   │   ├── data_cleaning.sql   
│   │   └── analysis_views.sql  
│   │   
│   ├── python/                    
│   │   ├── download_data.py       
│   │   └── import_to_sql.py       
│   │   
│   └── powerbi/                   
│       └── F1_Analytics_Dashboard.pbix
│
├── output/                        
│   ├── images/                    
│   │   ├── schema_diagram.png
│   │   └── dashboard_screenshot.png
│   └── reports/                   
│
├── docs/                          
│   ├── project_roadmap.md         
│   └── data_dictionary.md         
│
├── .gitignore                     
├── requirements.txt               
└── README.md                      
