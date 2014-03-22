program jeden;

	type
	drzewo = ^wezel;
	wezel = record
		klucz, wartosc, ilosc_dowiazan: Integer;
		suma: LongInt; //suma od <0..klucz>
		lsyn, psyn : drzewo
	end;




procedure stworz_wezel(var d: drzewo; const klucz, wartosc: Integer);
begin
	new(d);
	d^.ilosc_dowiazan := 1;
	d^.klucz := klucz;
	d^.wartosc := wartosc;
	d^.suma := 0;
	d^.psyn := nil;
	d^.lsyn := nil;
end;

procedure uzupelnij_suma(var d: drzewo);
begin
	if (d^.lsyn <> nil) then begin
		d^.suma := d^.lsyn^.suma;
	end;
	d^.suma := d^.suma + d^.wartosc;
end;

procedure dodaj_do_drzewa_pustego(var d: drzewo; const klucz, wartosc: integer; var liczba_wezlow: Integer);
begin
	if (d = nil) then
	begin
		inc(liczba_wezlow);
		stworz_wezel(d, klucz, wartosc);
		uzupelnij_suma(d);
	end
	else if (klucz > d^.klucz) then
	begin
		if (d^.psyn = nil) then
		begin
			inc(liczba_wezlow);
			stworz_wezel(d^.psyn, klucz, wartosc);
			uzupelnij_suma(d^.psyn);
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
			uzupelnij_suma(d^.lsyn);
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
		uzupelnij_suma(drzewo_wyjsciowe);
		dopisz_wezel(drzewo_wczesniejsze^.lsyn, drzewo_wyjsciowe^.lsyn);
	end
	else if (klucz < drzewo_wczesniejsze^.klucz) then
	begin
		if (drzewo_wczesniejsze^.lsyn = nil) then
		begin
			stworz_wezel(drzewo_wyjsciowe^.lsyn, klucz, wartosc);
			inc(ilosc_nowych_wezlow);
			uzupelnij_suma(drzewo_wyjsciowe^.lsyn);
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
	uzupelnij_suma(drzewo_wyjsciowe);
end;

procedure wypisz_drzewo(d : drzewo);
begin
	if not (d = nil) then
	begin
		wypisz_drzewo(d^.lsyn);
		wypisz_drzewo(d^.psyn);
		
		writeln('wartosc: ', d^.klucz, ' ilosc_dowiazan: ', d^.ilosc_dowiazan,' suma: ', d^.suma);
	end;
end;

procedure usun_wezel(var wezel: drzewo);
begin
	dispose(wezel);
	wezel := nil;
end;

procedure usun_cale_drzewo(var d : drzewo);
begin
	if not (d = nil) then
	begin
		dec(d^.ilosc_dowiazan);	
		if (d^.ilosc_dowiazan = 0) then begin
			usun_cale_drzewo(d^.lsyn);
			usun_cale_drzewo(d^.psyn);
			usun_wezel(d);
		end;
	end;
end;

function daj_minimalny(const d: drzewo): drzewo;
begin
	
	if d <> nil then begin
		if (d^.lsyn <> nil) then begin
			daj_minimalny := daj_minimalny(d^.lsyn);
		end else begin
			daj_minimalny := d;
		end;
	end else begin
		daj_minimalny := nil;
	end;
end;



procedure kopiuj_minimalny(const drzewo_wczesniejsze: drzewo; var drzewo_wyjsciowe: drzewo);
begin
	
	if drzewo_wczesniejsze <> nil then begin
		if (drzewo_wczesniejsze^.lsyn <> nil) then begin
			kopiuj_wezel(drzewo_wczesniejsze, drzewo_wyjsciowe);
			dopisz_wezel(drzewo_wczesniejsze^.psyn, drzewo_wyjsciowe^.psyn);
			kopiuj_minimalny(drzewo_wczesniejsze^.lsyn, drzewo_wyjsciowe^.lsyn);
			uzupelnij_suma(drzewo_wyjsciowe);
		end else begin
			dopisz_wezel(drzewo_wczesniejsze^.psyn, drzewo_wyjsciowe);
		end;
	end;
end;



procedure usun_wezel_z_drzewa(const drzewo_wczesniejsze: drzewo;
	var drzewo_wyjsciowe: drzewo; const klucz: Integer; var ilosc_nowych_wezlow: Integer);
begin
	if drzewo_wczesniejsze <> nil then begin
		inc(ilosc_nowych_wezlow);
		if drzewo_wczesniejsze^.klucz > klucz then begin
			kopiuj_wezel(drzewo_wczesniejsze, drzewo_wyjsciowe);
			usun_wezel_z_drzewa(drzewo_wczesniejsze^.lsyn, drzewo_wyjsciowe^.lsyn, klucz, ilosc_nowych_wezlow);
			uzupelnij_suma(drzewo_wyjsciowe);
		end else if drzewo_wczesniejsze^.klucz < klucz then begin
			kopiuj_wezel(drzewo_wczesniejsze, drzewo_wyjsciowe);
			usun_wezel_z_drzewa(drzewo_wczesniejsze^.psyn, drzewo_wyjsciowe^.psyn, klucz, ilosc_nowych_wezlow);
			uzupelnij_suma(drzewo_wyjsciowe);
		end else begin
			if drzewo_wczesniejsze^.psyn = nil then begin
				dopisz_wezel(drzewo_wczesniejsze^.lsyn, drzewo_wyjsciowe);
				dec(ilosc_nowych_wezlow);
			end else begin
				kopiuj_wezel(daj_minimalny(drzewo_wczesniejsze^.psyn), drzewo_wyjsciowe);
				kopiuj_minimalny(drzewo_wczesniejsze^.psyn, drzewo_wyjsciowe^.psyn);
				dopisz_wezel(drzewo_wczesniejsze^.lsyn, drzewo_wyjsciowe^.lsyn);
				uzupelnij_suma(drzewo_wyjsciowe);
			end;
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
		end;
	end;
	writeln('liczba wezlow: ', liczba_wezlow);
	readln(liczba);
	d2 := nil;
	usun_wezel_z_drzewa(d, d2, liczba, liczba_wezlow);
	
	wypisz_drzewo(d);
	writeln('drgie dzewo');
	writeln('liczba wezlow: ', liczba_wezlow);
	wypisz_drzewo(d2);
	usun_cale_drzewo(d);
	usun_cale_drzewo(d2);
	
end.
