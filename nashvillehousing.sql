
Select *
FROM portfolio_projects."NashvilleHousing"


-- Standardize Date Format

Select saledate, CAST(saledate AS Date)
FROM portfolio_projects."NashvilleHousing"


Update portfolio_projects."NashvilleHousing"
SET saledate = CAST(saledate AS Date)
/*
Select *
FROM portfolio_projects."NashvilleHousing"
WHERE length(propertyaddress) = 0
*/

-- Breaking out Address Into Individual Columns (Address, City, State)

Select substring(propertyaddress, 1, POSITION(',' in propertyaddress) - 1) as Address,
		substring(propertyaddress, POSITION(',' in propertyaddress) + 1, length(propertyaddress)) as Address
FROM portfolio_projects."NashvilleHousing"
WHERE POSITION(',' in propertyaddress) > 0


-- Creating new columns to populate the address and city as split values

ALTER TABLE portfolio_projects."NashvilleHousing"
ADD PropertySplitAddress varchar(255)

ALTER TABLE portfolio_projects."NashvilleHousing"
ADD PropertySplitCity varchar(255)

UPDATE portfolio_projects."NashvilleHousing"
SET PropertySplitAddress = substring(propertyaddress, 1, POSITION(',' in propertyaddress) - 1) 
							WHERE POSITION(',' in propertyaddress) > 0

UPDATE portfolio_projects."NashvilleHousing"
SET PropertySplitCity = substring(propertyaddress, POSITION(',' in propertyaddress) + 1, length(propertyaddress))
						WHERE POSITION(',' in propertyaddress) > 0
						

-- Change Y and N to Yes and No in "Sold as Vacant" field 
Select distinct(soldasvacant) , count(soldasvacant)
FROM portfolio_projects."NashvilleHousing"
Group By soldasvacant
Order by 2


Select soldasvacant,
CASE When soldasvacant = 'Y' Then 'Yes'
	 When soldasvacant = 'N' Then 'No'
	 ELSE soldasvacant
	 END 
FROM portfolio_projects."NashvilleHousing"

UPDATE portfolio_projects."NashvilleHousing"
SET soldasvacant = CASE When soldasvacant = 'Y' Then 'Yes'
	 When soldasvacant = 'N' Then 'No'
	 ELSE soldasvacant
	 END 
	 
-- Delete unused columns


ALTER TABLE portfolio_projects."NashvilleHousing"
DROP Column owneraddress, 
DROP Column taxdistrict, 
DROP Column propertyaddress,
DROP Column SaleDate

Select *
FROM portfolio_projects."NashvilleHousing"