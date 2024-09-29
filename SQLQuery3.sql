Select *
from PortfolioProject.dbo.NashvilleHousing

--standardizing the date format

Select SaleDateConverted, CONVERT(date, Saledate)
from PortfolioProject.dbo.NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate = CONVERT(Date,Saledate)

ALTER Table NashvilleHousing
Add SaleDateConverted Date

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date, Saledate)



--Populate Property Address Data


Select *
from PortfolioProject.dbo.NashvilleHousing
--where PropertyAddress is NULL
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
 ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is NULL


update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
 ON a.ParcelID = b.ParcelID
 AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is NULL



--Dividing Address column into individual columns (Address, City, State)

select PropertyAddress
from PortfolioProject.dbo.NashvilleHousing 


Select
SUBSTRING(PropertyAddress, 1, CHARINDEX(',' , PropertyAddress) -1 ) as Address
, SUBSTRING(PropertyAddress,CHARINDEX(',' , PropertyAddress) + 1 , LEN(PropertyAddress)) as Address

from PortfolioProject.dbo.NashvilleHousing 


ALTER Table NashvilleHousing
Add PropertySplitAddress NVARCHAR(255)

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',' , PropertyAddress) -1 )

ALTER Table NashvilleHousing
Add PropertySplitCity NVARCHAR(255)

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress,CHARINDEX(',' , PropertyAddress) + 1 , LEN(PropertyAddress))


select *
from PortfolioProject.dbo.NashvilleHousing 



select OwnerAddress
from PortfolioProject.dbo.NashvilleHousing 



select 
PARSENAME(REPLACE(OwnerAddress,',', '.'), 3),
 PARSENAME(REPLACE(OwnerAddress,',', '.'), 2),
 PARSENAME(REPLACE(OwnerAddress,',', '.'), 1)
from PortfolioProject.dbo.NashvilleHousing 



ALTER Table NashvilleHousing
Add OwnerSplitAddress NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',', '.'), 3)

ALTER Table NashvilleHousing
Add OwnerSplitCity NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitCity =  PARSENAME(REPLACE(OwnerAddress,',', '.'), 2)

ALTER Table NashvilleHousing
Add OwnerSplitState NVARCHAR(255)

UPDATE NashvilleHousing
SET OwnerSplitState =  PARSENAME(REPLACE(OwnerAddress,',', '.'), 1)


select *
from PortfolioProject.dbo.NashvilleHousing 


--Changing Y and N to Yes and No in 'Sold as Vacant' field

select distinct(SoldAsVacant), COUNT(SoldAsVacant)
from PortfolioProject.dbo.NashvilleHousing 
Group by SoldAsVacant
Order by 2


select SoldAsVacant,
 CASE when  SoldAsVacant = 'Y' THEN 'YES'
      when SoldAsVacant = 'N' THEN 'NO'
	  Else  SoldAsVacant
	  END
from PortfolioProject.dbo.NashvilleHousing 


UPDATE NashvilleHousing
SET SoldAsVacant = CASE when  SoldAsVacant = 'Y' THEN 'YES'
      when SoldAsVacant = 'N' THEN 'NO'
	  Else  SoldAsVacant
	  END
from PortfolioProject.dbo.NashvilleHousing 




--Remove Duplicates
WITH RowNumCTE AS(
select *,
  ROW_NUMBER() over (
  PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference ORDER BY UniqueID)  row_num
from PortfolioProject.dbo.NashvilleHousing
--ORDER BY ParcelID
)
SELECT *
from RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress


select *
from PortfolioProject.dbo.NashvilleHousing



--Delete Unused Columns

select *
from PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress


ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN SaleDate
