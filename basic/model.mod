set ProductGroups;
param space{ProductGroups};


param nRows;
set Rows:=1..nRows;

param cashierCount;
param cashierLength;

#változok
var cashiertoplace{Rows}>=0, binary;
var productplace{Rows,ProductGroups} binary;
var rowelength{Rows}>=0;
var BuildingLength>=0;

#megszorítások
#az összes kasszát be kell építeni
s.t. PlaceAllCashier:
	sum{r in Rows}cashiertoplace[r]=cashierCount;
#ne szeparáljuk a termékeket
s.t. OneProductOnOneRow{p in ProductGroups}:
    sum{r in Rows} productplace[r,p] = 1;
#faszomatama
s.t. SetBuildingLength{r in Rows}:
    BuildingLength >= rowelength[r];
#fasz
s.t. miafasz{r in Rows}:
	sum{p in ProductGroups}productplace[r,p]*space[p]+cashiertoplace[r]*cashierLength=rowelength[r];


minimize FASZOM{r in Rows}:BuildingLength;
solve;
printf "%f\n",BuildingLength;
end;
