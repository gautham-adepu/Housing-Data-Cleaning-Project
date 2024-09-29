This project demonstrates data cleaning and preprocessing techniques on the Nashville Housing dataset, aiming to enhance data quality and consistency for further analysis.

Project Overview
The dataset includes various fields such as property addresses, sale dates, and ownership details. The cleaning process involved:

1.Standardizing Date Formats: The SaleDate column was updated to a consistent date format using SQL's CONVERT() function, and a new column SaleDateConverted was added for future reference.

2.Populating Missing Property Address Data: Missing PropertyAddress entries were filled by joining records with matching ParcelIDs.

3.Splitting Address Fields: The PropertyAddress and OwnerAddress fields were split into separate columns for street address, city, and state to facilitate better analysis.

4.Normalizing the 'Sold as Vacant' Field: The 'Y' and 'N' values in the SoldAsVacant field were standardized to 'YES' and 'NO' for clarity.

5.Removing Duplicate Records: Duplicate rows were identified and removed using SQL's ROW_NUMBER() function based on key attributes such as ParcelID, SalePrice, and SaleDate.

6.Dropping Unused Columns: Irrelevant columns such as OwnerAddress, TaxDistrict, and PropertyAddress were removed to streamline the dataset.
