# Neflix_SQL_Project-
**Netflix Content Analysis project using MS SQL Server on records of movies and TV shows. Performed data cleaning, null handling, and duplicate removal. Solved 15+ business queries using CTEs, Window Functions, STRING_SPLIT, ranking, and date functions to extract insights on ratings, trends, actors, and content growth.**
![image alt](https://github.com/Sandeepverma3958/Neflix_SQL_Project-/blob/882cd6eaea2df34a4711371a1ae797cb4d705966/Netflix-Dolby-Atmos.webp)

# 🎬 Netflix Content Analysis Using SQL

## 📌 Project Overview

This project focuses on performing **end-to-end data analysis of Netflix content using Microsoft SQL Server**. The objective is to clean, explore, and analyze Netflix's movie and TV show catalog to identify meaningful patterns related to **content type, ratings, release trends, countries, genres, directors, actors, and content distribution**.

The project started with **8,807 records** containing information about Netflix movies and TV shows. Through data profiling and cleaning, missing values, inconsistent ratings, and duplicate records were identified and handled. After the initial NULL-removal process, the working dataset contained **5,332 records**.

The analysis uses SQL to answer **15+ real-world business questions** and demonstrate practical skills in data cleaning, exploratory data analysis, analytical querying, and business insight generation.

---

## 🎯 Business Problems

The project aims to answer the following business questions:

### Content Analysis

* What is the total number of **Movies vs TV Shows**?
* What percentage of the catalog belongs to each content type?
* Which **ratings** are most common for Movies and TV Shows?
* What is the **longest movie** available on Netflix?
* Which types of content dominate the Netflix catalog?

### Time-Based Analysis

* How has Netflix content changed over the years?
* How many titles were released in each year?
* What is the **average number of content releases per year**?
* How much content was added to Netflix during the **last five years**?

### Country & Market Analysis

* How many different countries are represented in the dataset?
* Which countries contribute the highest number of Netflix titles?
* What are the **year-wise content trends in India**?
* What is the average number of titles released in India per year?

### Genre & Content Analysis

* How many **documentary movies** are available?
* Which genres/categories appear most frequently?
* What are the most common content categories?
* Which actors appear most frequently in Netflix content?
* Which directors have the highest number of titles?

### Description & Keyword Analysis

* Which titles contain **violence-related keywords** in their descriptions?
* Can content be categorized based on specific keywords found in descriptions?

---

# 📊 Dataset

The project uses the **Netflix Titles dataset**, containing information about movies and TV shows available on Netflix.

### Dataset Size

| Metric                                 |                 Value |
| -------------------------------------- | --------------------: |
| Initial Records                        |             **8,807** |
| Distinct Countries                     |               **749** |
| Working Records After Initial Cleaning |             **5,332** |
| Content Types                          | **Movies & TV Shows** |

---

# 🧩 Dataset Features

The dataset contains the following major attributes:

| Column         | Description                                   |
| -------------- | --------------------------------------------- |
| `show_id`      | Unique identifier for each Netflix title      |
| `type`         | Type of content — Movie or TV Show            |
| `title`        | Name of the movie or TV show                  |
| `director`     | Director of the content                       |
| `cast`         | Actors appearing in the content               |
| `country`      | Country/countries associated with the content |
| `date_added`   | Date when the title was added to Netflix      |
| `release_year` | Original release year of the content          |
| `rating`       | Content rating such as TV-MA, PG-13, etc.     |
| `duration`     | Movie duration or number of seasons           |
| `listed_in`    | Genre/category of the content                 |
| `description`  | Short description of the movie or TV show     |

---

# 🗄️ Database & Table

### Database

```sql
PROJECT
```

### Table

```sql
NETFLIX_TITLES
```

The main analysis is performed on the `NETFLIX_TITLES` table.

The table contains **12 major columns** covering content information, people involved, geographic information, dates, ratings, duration, genres, and descriptions.

---

# 🔍 Data Profiling & Data Quality Checks

Before performing analysis, the dataset was profiled to understand its structure and data quality.

### 1. Dataset Size

```sql
SELECT COUNT(*) AS Total_Count
FROM netflix_titles;
```

Initial dataset size:

**8,807 records**

### 2. Content Types

```sql
SELECT DISTINCT type
FROM netflix_titles;
```

The dataset contains:

* Movies
* TV Shows

### 3. Country Analysis

```sql
SELECT COUNT(DISTINCT country) AS No_of_Different_Countries
FROM netflix_titles;
```

The dataset contains:

**749 distinct country values**

### 4. Release Year Analysis

```sql
SELECT DISTINCT release_year
FROM netflix_titles
ORDER BY release_year ASC;
```

This was used to understand the range and distribution of content release years.

### 5. Rating Validation

Distinct ratings were examined to identify incorrect or inconsistent values.

Examples of incorrect values found in the `rating` column:

* `84 min`
* `66 min`
* `74 min`
* `NULL`

These values were investigated as part of the data-cleaning process.

---

# 🧹 Data Cleaning

Data cleaning was performed before the main analysis to improve data quality and consistency.

### Missing Value Detection

NULL values were checked across all major columns using conditional aggregation:

```sql
SUM(CASE WHEN column_name IS NULL THEN 1 ELSE 0 END)
```

The major missing-value issues identified included:

| Column     | Missing Records |
| ---------- | --------------: |
| Director   |           2,634 |
| Cast       |             825 |
| Country    |             831 |
| Date Added |              10 |
| Rating     |               4 |
| Duration   |               3 |

### Handling Missing Values

Rows containing NULL values in selected analytical fields were removed according to the cleaning approach used in the project.

After this cleaning step:

**8,807 → 5,332 records**

### Duplicate Analysis

Duplicate titles were identified using:

```sql
SELECT title, COUNT(*) AS Count
FROM netflix_titles
GROUP BY title
HAVING COUNT(*) > 1;
```

Duplicate/inconsistent records were investigated and removed where required.

### Incorrect Rating Values

The `rating` column was checked for values that actually represented movie durations:

* `84 min`
* `66 min`
* `74 min`

These records were identified as data-quality issues and handled during cleaning.

---

# 📈 Exploratory Data Analysis (EDA)

After data cleaning, SQL-based EDA was performed to understand the structure and characteristics of Netflix content.

### EDA Performed

#### 1. Content Type Distribution

* Movies vs TV Shows
* Count and proportion of each content type

#### 2. Rating Analysis

* Most common ratings
* Rating distribution by content type

#### 3. Release Year Analysis

* Number of titles released by year
* Average content released per year
* Recent content trends

#### 4. Country Analysis

* Country-wise content distribution
* Top countries by number of titles
* India-specific content analysis

#### 5. Genre Analysis

* Most common genres
* Documentary content
* Genre distribution

#### 6. People Analysis

* Top actors
* Top directors
* Number of titles associated with each person

#### 7. Duration Analysis

* Longest movie
* Movie duration analysis
* TV Show season analysis

#### 8. Description Analysis

* Keyword-based content classification
* Identification of descriptions containing violence-related terms

---

# 🛠️ SQL Techniques Used

The project demonstrates a range of SQL Server techniques.

### Basic SQL

* `SELECT`
* `WHERE`
* `DISTINCT`
* `ORDER BY`
* `TOP`
* `COUNT`
* `COUNT(DISTINCT)`

### Aggregation

* `COUNT()`
* `AVG()`
* `SUM()`
* `GROUP BY`
* `HAVING`

### Conditional Logic

* `CASE`
* Conditional aggregation
* NULL handling

### Advanced SQL

* **CTEs**
* **Window Functions**
* `RANK()`
* `AVG() OVER()`
* Subqueries

### String & Text Analysis

* `STRING_SPLIT()`
* `TRIM()`
* `REPLACE()`
* String filtering
* Keyword-based analysis

### Date Analysis

* `YEAR()`
* `DATEADD()`
* Date filtering
* Year-wise analysis

### Data Cleaning

* NULL detection
* `CASE`
* `TRIM()`
* `REPLACE()`
* `CAST()`
* Data-type validation
* Duplicate detection

---

# 🔄 Project Workflow

```text
Raw Netflix Dataset
        ↓
Database Creation
        ↓
Table & Data-Type Inspection
        ↓
Data Profiling
        ↓
NULL Value Analysis
        ↓
Data Cleaning
        ↓
Duplicate Detection
        ↓
Invalid Value Detection
        ↓
Exploratory Data Analysis
        ↓
Business Question Analysis
        ↓
Advanced SQL Queries
        ↓
Business Insights
```

---

# 💡 Key Business Insights

The analysis is designed to provide insights into:

* Netflix's **Movie vs TV Show content mix**
* Most common **content ratings**
* Content growth across different years
* Country-wise content contribution
* India's content production/release trends
* Most common genres and categories
* Frequently appearing actors and directors
* Movie duration patterns
* Recent content additions
* Description-based content classification

These insights can help understand **content distribution, catalog composition, geographic trends, and content characteristics**.

---

# 🧰 Tools & Technologies

* **Microsoft SQL Server**
* **SQL**
* Data Cleaning
* Exploratory Data Analysis
* Statistical Aggregation
* Window Functions
* CTEs
* String & Date Functions

---

# 📚 Skills Demonstrated

* SQL Data Analysis
* Data Cleaning
* Data Profiling
* Exploratory Data Analysis
* Business Problem Solving
* Analytical Query Development
* Aggregation & Grouping
* Window Functions
* CTEs
* String Manipulation
* Date Analysis
* Data Quality Validation

---

# 👨‍💻 Project Objective

The main objective of this project was to demonstrate how **SQL can be used to transform a raw dataset into structured business insights** through data cleaning, exploratory analysis, and advanced analytical queries.

The project showcases practical SQL skills relevant to **Data Analyst and Business Analyst roles**, particularly in working with large datasets and converting business questions into analytical SQL queries.

