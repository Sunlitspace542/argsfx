	org $8000,0

	nop
	nop

	list on
	ifv "path"
	wai
	endc

	ifnv "RATS"
	nop
	endc

	string fred[50]
	string fred="WOT A LOAD OF RUBBISH..."
	printf "FRED = %$fred"
	string bill[40]
	string bill="ENV FLAGS..."
	printf "BILL = %$bill"
	getenv bill="dlflags"
	printf "BILL = %$BILL"
	end
