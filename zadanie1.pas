program zadanie1;
uses drzewa;

const IGNOROWANIE = 'zignorowano';
const OGR_DZIEDZINA = 1000000000;
const OGR_ZW = 1000;
const OGR_LICZBA_PRZYPISAN = 1000000;

var tablica_drzew: array [0..OGR_LICZBA_PRZYPISAN] of drzewo; 
var liczba_wezlow: LongInt;
var indeks: LongInt;
var liczba_poprawnych_polecen: LongInt;

procedure wczytaj_pierwsza_litere(const linijka: String); forward;
procedure wczytaj_przypisanie(const linijka: String); forward;
procedure wczytaj_czysc(const linijka: String); forward;
procedure wczytaj_suma(const linijka: String); forward;
function pozycja_litery(const slowo: String; const litera: Char; od_momentu: Integer):Integer; forward;
function parsuj_int(const slowo: String; const ograniczenie: LongInt): LongInt; forward;
procedure wczytaj_linijke(); forward;
procedure wypisz_zignorowanie(); forward;
function dlugosc_liczby(const liczba: LongInt): Integer; forward;
procedure przypisanie(const x, y: LongInt); forward;
procedure suma(const t, a, b: LongInt); forward;
procedure czysc(const t: LongInt); forward;


procedure wczytaj_linijke();
var linijka: String;
begin
	readln(linijka);
	wczytaj_pierwsza_litere(linijka);
end;

procedure wypisz_zignorowanie();
begin
	writeln(IGNOROWANIE);
end;

procedure wczytaj_pierwsza_litere(const linijka: String);
begin
	if (length(linijka)  > 1) then begin
		case linijka[1] of
			'f': wczytaj_przypisanie(linijka);
			's': wczytaj_suma(linijka);
			'c': wczytaj_czysc(linijka);
		else
			wypisz_zignorowanie();
		end;
	end else wypisz_zignorowanie();
end;

procedure wczytaj_przypisanie(const linijka: String);
var dlugosc_linijki, pozycja_nawias: Integer;
var prawidlowe_przypisanie: Boolean;
var argument, wartosc: LongInt;
begin
	prawidlowe_przypisanie := false;
	dlugosc_linijki := length(linijka);
	if (dlugosc_linijki <= 19) then begin
		if (linijka[2] = '(') then begin
			pozycja_nawias := pozycja_litery(linijka, ')', 3);
			if (pozycja_nawias < dlugosc_linijki) then begin
				argument := 
					parsuj_int(copy(linijka, 3, pozycja_nawias - length('f()')), OGR_DZIEDZINA);
				 //copy jest od (slowo, od i ile)
				if (argument >= 0) then begin
					if (linijka[pozycja_nawias + 1] = ':') 
						and (linijka[pozycja_nawias + 2] = '=') then begin
						wartosc := 
							parsuj_int(copy(linijka, pozycja_nawias + 3, dlugosc_linijki - pozycja_nawias - 2), OGR_ZW);
						if (wartosc >= 0) then begin
							prawidlowe_przypisanie := true;
						end;
					end;
				end;
			end;
		end;
	end;
	
	if(prawidlowe_przypisanie) then begin
		inc(indeks);
		przypisanie(argument, wartosc);
		inc(liczba_poprawnych_polecen);
	end else begin
		wypisz_zignorowanie();
	end;
end;

procedure wczytaj_czysc(const linijka: String);
var dlugosc_linijki, pozycja_nawias: Integer;
var prawidlowe_czyszczenie: Boolean;
var argument: LongInt;
begin
	prawidlowe_czyszczenie := false;
	dlugosc_linijki := length(linijka);
	if (dlugosc_linijki <= 14) then begin
		if (linijka[2] = 'z') and
			(linijka[3] = 'y') and
			(linijka[4] = 's') and
			(linijka[5] = 'c') and
			(linijka[6] = '(') then begin
			
			pozycja_nawias := pozycja_litery(linijka, ')', 7);
			if (pozycja_nawias = dlugosc_linijki) then begin
				argument := 
					parsuj_int(copy(linijka, 7, pozycja_nawias - length('czysc()')), OGR_LICZBA_PRZYPISAN);
				if (argument >= 0) and (argument <= indeks) then begin
					prawidlowe_czyszczenie := true;
				end;
			end;
		end;
	end;
	if(prawidlowe_czyszczenie) then begin
		czysc(argument);
		inc(liczba_poprawnych_polecen);
	end else begin
		wypisz_zignorowanie();
	end;
end;

procedure wczytaj_suma(const linijka: String);
var dlugosc_linijki, pozycja_nawias, pozycja_kropka, pozycja_przecinek: Integer;
var prawidlowa_suma: Boolean;
var t, a, b: LongInt;
begin
	prawidlowa_suma := false;
	dlugosc_linijki := length(linijka);
	if (dlugosc_linijki <= 35) then begin
		if (linijka[2] = 'u') and
			(linijka[3] = 'm') and
			(linijka[4] = 'a') and
			(linijka[5] = '(') then begin
			
			pozycja_przecinek := pozycja_litery(linijka, ',', 6);
			if (pozycja_przecinek < dlugosc_linijki) then begin
				t := 
					parsuj_int(copy(linijka, 6, pozycja_przecinek - length('suma(,')), OGR_LICZBA_PRZYPISAN);
				 //copy jest od (slowo, od i ile)
				if (t >= 0) and (t <= indeks) then begin
					pozycja_kropka := pozycja_litery(linijka, '.', pozycja_przecinek);
						//skoro tu jestem to nie ma kropki po w "liczbie"
					if (pozycja_kropka < dlugosc_linijki) 
						and (linijka[pozycja_kropka + 1] = '.') then begin
						
						a := 
							parsuj_int(copy(linijka, pozycja_przecinek + 1,
								pozycja_kropka - pozycja_przecinek - 1), OGR_DZIEDZINA);
							
						if (a >= 0) then begin
							pozycja_nawias := pozycja_litery(linijka, ')', 1); 
							if (pozycja_nawias = dlugosc_linijki) then begin 
								b := 
									parsuj_int(copy(linijka, pozycja_przecinek + dlugosc_liczby(a) + 3,
										pozycja_nawias - (pozycja_przecinek + dlugosc_liczby(a) + 3)), OGR_DZIEDZINA);
								if (a <= b) and (b >= 0) then begin
									prawidlowa_suma := true;
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
	
	if (prawidlowa_suma)then begin
		suma(t,a,b);
		inc(liczba_poprawnych_polecen);
	end else begin
		wypisz_zignorowanie();
	end;
end;

function pozycja_litery(const slowo: String; const litera: Char; od_momentu: Integer): Integer;
begin
	while (od_momentu < length(slowo)) and (slowo[od_momentu] <> litera) do
		od_momentu := od_momentu + 1;
	pozycja_litery := od_momentu;
end;

function parsuj_int(const slowo: String; const ograniczenie: LongInt): LongInt;
var wartosc, blad: LongInt;
begin
	val(slowo, wartosc, blad);
	if (length(slowo) <> dlugosc_liczby(wartosc)) or (blad <> 0) 
		or (wartosc > ograniczenie) then begin
		parsuj_int := -1;
	end else begin
		parsuj_int := wartosc;
	end;
end;

function dlugosc_liczby(const liczba: LongInt): Integer;
var pom: LongInt;
var wynik: Integer;
begin
	pom := liczba;
	wynik := 0;
	while pom > 0 do begin
		wynik := wynik + 1;
		pom := pom div 10;
	end;
	if (liczba = 0) then begin
		wynik := 1;
	end;
	dlugosc_liczby := wynik;
end;

procedure przypisanie(const x, y: LongInt);
begin
	if (tablica_drzew[indeks - 1] = nil) then begin
		if (y > 0) then begin
			dodaj_do_drzewa_pustego(tablica_drzew[indeks], x, y, liczba_wezlow);
		end;
	end else begin
		if (y > 0) then begin
			if not (czy_istnieje(tablica_drzew[indeks - 1], x, y)) then begin
				dodaj_do_drzewa(tablica_drzew[indeks - 1], tablica_drzew[indeks], x, y, liczba_wezlow)
			end else begin
				dopisz_wezel(tablica_drzew[indeks - 1], tablica_drzew[indeks]);
			end;
		end else begin
			usun_wezel_z_drzewa(tablica_drzew[indeks - 1], tablica_drzew[indeks], x, liczba_wezlow) 
		end;
	end;
	writeln('wezlow: ', liczba_wezlow);
end;

procedure suma(const t, a, b: LongInt);
var wynik: LongInt;
begin
	if (a > 0) then begin
		wynik := oblicz_sume(tablica_drzew[t], b) - oblicz_sume(tablica_drzew[t], a - 1);
	end else begin
		wynik := oblicz_sume(tablica_drzew[t], b);
	end;
	
	writeln('suma(',t,',',a,'..',b,')=',wynik);
end;

procedure czysc(const t: LongInt);
begin
	usun_cale_drzewo(tablica_drzew[t], liczba_wezlow);
	writeln('wezlow: ', liczba_wezlow);
end;

procedure inicjacja();
var licznik: LongInt;
begin
	licznik := 0;
	while (licznik <= OGR_LICZBA_PRZYPISAN) do begin
		tablica_drzew[licznik] := nil;
		inc(licznik);
	end;
	indeks := 0;
	liczba_wezlow := 0;
	liczba_poprawnych_polecen := 0;
end;

procedure czyszczenie();
var licznik: LongInt;
begin
	licznik := 0;
	while (licznik <= OGR_LICZBA_PRZYPISAN) do begin
		usun_cale_drzewo(tablica_drzew[OGR_LICZBA_PRZYPISAN - licznik], liczba_wezlow);
		inc(licznik);
	end;
end;

begin
	inicjacja();
	while (not seekeof) and (liczba_poprawnych_polecen <= OGR_LICZBA_PRZYPISAN)do begin
		wczytaj_linijke();
	end;
	
// 	while not seekeof do begin
// 		wypisz_zignorowanie;
// 	end;
	czyszczenie();
end.