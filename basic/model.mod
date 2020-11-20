param nRows;
set Rows := 1..nRows;
set ProductGroups;
param cashierCount;
param cashierLength;
param space{ProductGroups};


var BuildingLength >= 0;
var RowLength{Rows} >= 0;
var CashiersInRow{Rows} >= 0, integer;
var Put{Rows, ProductGroups} binary;


s.t. PlaceAllCashiers{r in Rows}:
    CashiersInRow[r] <= cashierCount;

s.t. MustUseAllCashiers:
    sum{r in Rows} CashiersInRow[r] = cashierCount;

s.t. CantSeparateProductGroups{p in ProductGroups}:
    sum{r in Rows} Put[r,p] = 1;

s.t. SetLengthOfRow{r in Rows}:
    RowLength[r] = sum{p in ProductGroups} Put[r,p]*space[p] + CashiersInRow[r]*cashierLength;

s.t. SetLengthOfBuilding{r in Rows}:
    BuildingLength >= RowLength[r];

 
minimize Length: BuildingLength;


solve;

printf "%f\n",BuildingLength;

end;