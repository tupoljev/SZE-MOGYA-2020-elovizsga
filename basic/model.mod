set ProductGroups;
param space{ProductGroups};



param nRows;
set Rows:=1..nRows;

param cashierCount;
param cashierLength;
/*products*/
set ProductGroups;
param space{ProductGroups};

/*rows*/
param nRows;
set Row := 1..nRows;

/*cashiers*/
param cashierCount;
param cashierLength;
var cashiersinarow{Row} >= 0, integer;

/*rows*/
var BuildingLength >= 0;
var rowlength{Row} >= 0;

/**/
var put{Row, ProductGroups} binary;

/*Megkotesek*/
s.t. CannotSeparateProducts{p in ProductGroups}:
	sum{r in Row} put[r,p] = 1;

s.t. PlaceAllCashiers{r in Row}:
	cashiersinarow[r] <= cashierCount;

s.t. MustUseAllCashiers:
	sum{r in Row} cashiersinarow[r] = cashierCount;

s.t. InitializeRowLength{r in Row}:
	rowlength[r] = sum{p in ProductGroups} put[r,p]*space[p] + cashiersinarow[r]*cashierLength;

s.t. InitializeBuildingLength{r in Row}:
	BuildingLength >= rowlength[r];


minimize ShopLength: BuildingLength;




solve;

printf "%f\n",BuildingLength;


end;
