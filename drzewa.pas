program jeden;

	type
	drzewo = ^wezel;
	wezel = record
		w, ilosc_dowiazan : integer;
		lsyn, psyn : drzewo
	end;




procedure make_wezel(var d: drzewo; x: Integer);
begin
	d^.w := x;
	d^.psyn := nil;
	d^.lsyn := nil;
end;

procedure insert(var d : drzewo; x : integer);
begin
	if (d = nil) then
	begin
		new(d);
		make_wezel(d, x);
	end
	else if (x > d^.w) then
	begin
		if (d^.psyn = nil) then
		begin
			new(d^.psyn);
			make_wezel(d^.psyn, x);
		end
		else 
		begin
			insert(d^.psyn, x);
		end;
	end
	else if (x < d^.w) then
	begin
		if (d^.lsyn = nil) then
		begin
			new(d^.lsyn);
			make_wezel(d^.lsyn, x);
		end
		else 
		begin
			insert(d^.lsyn, x);
		end;
	end;
end;

procedure printAll(d : drzewo);
begin
	if not (d = nil) then
	begin
		printAll(d^.lsyn);
		writeln(d^.w);
		printAll(d^.psyn);
	end;
end;

procedure removeAll(var d : drzewo);
begin
	if not (d = nil) then
	begin
		removeAll(d^.lsyn);
		removeAll(d^.psyn);
		dispose(d);
		d := nil;
	end;
end;

function get_min(var d: drzewo): drzewo;

begin
	
	if d <> nil then begin
		if (d^.lsyn <> nil) then begin
			get_min := get_min(d^.lsyn);
		end else begin
			get_min := d;
			d := d^.psyn;
		end;
	end else begin
		get_min := nil;
	end;
end;

procedure remove(var d: drzewo; wartosc: Integer);
var wartosc_pom: Integer;
var drzewo_pom: drzewo;
begin
	if d <> nil then begin
		if d^.w > wartosc then begin
			remove(d^.lsyn, wartosc);
		end else if d^.w < wartosc then begin
			remove(d^.psyn, wartosc);
		end else begin
			drzewo_pom := d;
			if d^.psyn = nil then begin
				d := d^.lsyn;
			end else begin
				d := get_min(d^.psyn);
				d^.lsyn := drzewo_pom^.lsyn;
				d^.psyn := drzewo_pom^.psyn;
			end;
			dispose(drzewo_pom);
		end;
	end;
end;


var 
	liczba: Integer;
	d: drzewo;
begin
	liczba := 2;
	d := nil;
	while not (liczba = 0) do
	begin
		readln(liczba);
		if (liczba > 0) then begin
			insert(d, liczba);
		end else if (liczba < 0) then begin
			remove(d, -liczba);
		end;
	end;
	
	printAll(d);
	removeAll(d);
end.
