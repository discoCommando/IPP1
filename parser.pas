unit parser;
interface
const IGNOROWANIE = 'Zignorowano';
procedure wczytaj_pierwsza_litere(const linijka: String);
procedure wczytaj_przypisanie(const linijka: String);
procedure wczytaj_czysc(const linijka: String);
procedure wczytaj_suma(const linijka: String);
function pozycja_litery(const slowo: String; const litera: Char; od_momentu: Integer):Integer;
function parsuj_int(const slowo: String; const ograniczenie: LongInt): LongInt;
procedure wczytaj_linijke();
procedure wypisz_zignorowanie();
function dlugosc_liczby(const liczba: LongInt): Integer;
implementation


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
	case linijka[0] of
		'f': wczytaj_przypisanie(linijka);
		's': wczytaj_suma(linijka);
		'c': wczytaj_czysc(linijka);
	else
		wypisz_zignorowanie();
	end;
end;

procedure wczytaj_przypisanie(const linijka: String);
begin
end;

procedure wczytaj_czysc(const linijka: String);
begin
end;

procedure wczytaj_suma(const linijka: String);
begin
end;

function pozycja_litery(const slowo: String; const litera: Char; od_momentu: Integer):Integer;
begin
	while (od_momentu < length(slowo)) and (slowo[od_momentu] <> litera) do
		od_momentu := od_momentu + 1;
	pozycja_litery := od_momentu;
end;

function parsuj_int(const slowo: String; const ograniczenie: LongInt): LongInt;
var wartosc, blad: LongInt;
begin
	val(slowo, wartosc, blad);
	if (length(slowo) <> dlugosc_liczby(wartosc)) or (blad <> 0) then begin
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
	dlugosc_liczby := wynik;
end;

begin
end.