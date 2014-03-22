program jeden;

	type
	drzewo = ^wezel;
	wezel = record
		klucz, wartosc, ilosc_dowiazan: Integer;
		lsyn, psyn : drzewo
	end;




procedure stworz_wezel(var d: drzewo; const klucz, wartosc: Integer);
begin
	new(d);
	d^.ilosc_dowiazan := 1;
	d^.klucz := klucz;
	d^.wartosc := wartosc;
	d^.psyn := nil;
	d^.lsyn := nil;
end;

procedure dodaj_do_drzewa_pustego(var d: drzewo; const klucz, wartosc: integer; var liczba_wezlow: Integer);
begin
	if (d = nil) then
	begin
		inc(liczba_wezlow);
		stworz_wezel(d, klucz, wartosc);
	end
	else if (klucz > d^.klucz) then
	begin
		if (d^.psyn = nil) then
		begin
			inc(liczba_wezlow);
			stworz_wezel(d^.psyn, klucz, wartosc);
		end
		else 
		begin
			dodaj_do_drzewa_pustego(d^.psyn, klucz, wartosc, liczba_wezlow);
		end;
	end
	else if (klucz < d^.klucz) then
	begin
		if (d^.lsyn = nil) then
		begin
			inc(liczba_wezlow);
			stworz_wezel(d^.lsyn, klucz, wartosc);
		end
		else 
		begin
			dodaj_do_drzewa_pustego(d^.lsyn, klucz, wartosc, liczba_wezlow);
		end;
	end;
end;

procedure kopiuj_wezel(const wezel: drzewo; var wezel_wyjsciowy: drzewo);//kopiuje wezel wezel
begin
	stworz_wezel(wezel_wyjsciowy, wezel^.klucz, wezel^.wartosc);
end;

procedure dopisz_wezel(const wezel: drzewo; var wezel_wyjsciowy: drzewo); //dopisuje wskaznik do wezel
begin
	wezel_wyjsciowy := wezel;
	if (wezel <> nil) then begin
		inc(wezel_wyjsciowy^.ilosc_dowiazan);
	end;
end;

procedure dodaj_do_drzewa(const drzewo_wczesniejsze: drzewo;
	var drzewo_wyjsciowe: drzewo; const klucz, wartosc: Integer; var ilosc_nowych_wezlow: Integer);
	
//dodaj do drzewa wartosc, trzeba miec pewnosc ze tej wartosci nie ma
begin
	inc(ilosc_nowych_wezlow);
	kopiuj_wezel(drzewo_wczesniejsze, drzewo_wyjsciowe);
	if (klucz > drzewo_wczesniejsze^.klucz) then
	begin
		if (drzewo_wczesniejsze^.psyn = nil) then
		begin
			stworz_wezel(drzewo_wyjsciowe^.psyn, klucz, wartosc);
			inc(ilosc_nowych_wezlow);
		end
		else 
		begin
			dodaj_do_drzewa(drzewo_wczesniejsze^.psyn, drzewo_wyjsciowe^.psyn, klucz, wartosc, ilosc_nowych_wezlow);
		end;
		dopisz_wezel(drzewo_wczesniejsze^.lsyn, drzewo_wyjsciowe^.lsyn);
	end
	else if (klucz < drzewo_wczesniejsze^.klucz) then
	begin
		if (drzewo_wczesniejsze^.lsyn = nil) then
		begin
			stworz_wezel(drzewo_wyjsciowe^.lsyn, klucz, wartosc);
			inc(ilosc_nowych_wezlow);
		end
		else 
		begin
			dodaj_do_drzewa(drzewo_wczesniejsze^.lsyn, drzewo_wyjsciowe^.lsyn, klucz, wartosc, ilosc_nowych_wezlow);
		end;
		dopisz_wezel(drzewo_wczesniejsze^.psyn, drzewo_wyjsciowe^.psyn);
	end else begin
		drzewo_wyjsciowe^.wartosc := wartosc;
		dopisz_wezel(drzewo_wczesniejsze^.psyn, drzewo_wyjsciowe^.psyn);
		dopisz_wezel(drzewo_wczesniejsze^.lsyn, drzewo_wyjsciowe^.lsyn);
	end;
end;

procedure wypisz_drzewo(d : drzewo);
begin
	if not (d = nil) then
	begin
		wypisz_drzewo(d^.lsyn);
		writeln('wartosc: ', d^.klucz, ' ilosc_dowiazan: ', d^.ilosc_dowiazan);
		wypisz_drzewo(d^.psyn);
	end;
end;

procedure usun_cale_drzewo(var d : drzewo);
begin
	if not (d = nil) then
	begin
		dec(d^.ilosc_dowiazan);	
		if (d^.ilosc_dowiazan = 0) then begin
			usun_cale_drzewo(d^.lsyn);
			usun_cale_drzewo(d^.psyn);
			dispose(d);
			d := nil;
		end;
	end;
end;

function daj_minimalny(var d: drzewo): drzewo;

begin
	
	if d <> nil then begin
		if (d^.lsyn <> nil) then begin
			daj_minimalny := daj_minimalny(d^.lsyn);
		end else begin
			daj_minimalny := d;
			d := d^.psyn;
		end;
	end else begin
		daj_minimalny := nil;
	end;
end;

procedure usun_wezel(var d: drzewo; wartosc: Integer);
var drzewo_pom: drzewo;
begin
	if d <> nil then begin
		if d^.klucz > wartosc then begin
			usun_wezel(d^.lsyn, wartosc);
		end else if d^.klucz < wartosc then begin
			usun_wezel(d^.psyn, wartosc);
		end else begin
			drzewo_pom := d;
			if d^.psyn = nil then begin
				d := d^.lsyn;
			end else begin
				d := daj_minimalny(d^.psyn);
				d^.lsyn := drzewo_pom^.lsyn;
				d^.psyn := drzewo_pom^.psyn;
			end;
			dispose(drzewo_pom);
		end;
	end;
end;


var 
	liczba, liczba_wezlow: Integer;
	d, d2: drzewo;
begin
	liczba := 2;
	d := nil;
	liczba_wezlow := 0;
	while not (liczba = 0) do
	begin
		readln(liczba);
		if (liczba > 0) then begin
			dodaj_do_drzewa_pustego(d, liczba, 1, liczba_wezlow);
		end else if (liczba < 0) then begin
			usun_wezel(d, -liczba);
		end;
	end;
	writeln('liczba wezlow: ', liczba_wezlow);
	readln(liczba);
	d2 := nil;
	dodaj_do_drzewa(d, d2, liczba, 1, liczba_wezlow);
	writeln('liczba wezlow: ', liczba_wezlow);
	wypisz_drzewo(d);
	writeln('drgie dzewo');
	wypisz_drzewo(d2);
	usun_cale_drzewo(d);
	usun_cale_drzewo(d2);
	
end.
