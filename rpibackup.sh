# !/bin/bash

# Changelog

# Versione 0.2a - 12/07/2014
# Passaggio a BitBucket per il controllo delle versioni
#
# Versione 0.1a - 08/07/2014
# Rilascio iniziale con funzioni base

#############################################################

# Variabili iniziali
versione="0.2a"
data="08 luglio 2014"
titolo="RPi Backup $versione"
sottotitolo="Utility salvataggio Raspberry Pi versione $versione del $data"

# ************ Funzioni varie **************

pausa(){
   read -p "$*"
}

uscita()
{
	dialog --clear --backtitle "$sottotitolo" --msgbox "Uscita dal programma come chiesto!" 6 45
	rm tmpscelta
	clear
	exit
}

scelta_operazione(){
dialog --clear --backtitle "$sottotitolo" --menu \
  "Fai la tua scelta per cortesia:" 0 0 0 \
S "Salvataggio intero sistema" \
R "Ripristino intero sistema" 2>tmpscelta

if [ "$?" = "0" ]
then
	_return=$(cat tmpscelta)
	if [ "$_return" = "S" ]
        then
		salvataggio
        fi
	if [ "$_return" = "R" ]
        then
		ripristino
        fi
else
	uscita
fi
}

installa_fsarchiver()
{
dialog --title "$titolo" --backtitle "$sottotitolo" --yesno "Vuoi installare fsarchiver?" 5 35
case $? in
0)
echo "ottimo"
;;
1)
uscita
;;
esac
# uscita
}

salvataggio()
{
# Routine Salvataggio completo: salvataggio MBR + Tabella partizioni + Filesystem partizioni
echo routine salvataggio
exit
}

ripristino()
{
# Routine Ripristino: MBR + Tabella partizioni + Filesystem partizioni
echo routine ripristino
exit
}

# ******** Fine funzioni varie ********

# Inizio script
dialog --title "$titolo" --backtitle "$sottotitolo" --msgbox "Benvenuto in $titolo" 5 33

# Verifica utente usato e presenza fsarchiver

if [ $UID != 0 ]
    then
        dialog --clear --backtitle "$sottotitolo" --msgbox  "Questo script deve  essere utilizzato solo come utente root." 6 70
        exit 1
fi

if which dfsarchiver >/dev/null; then
        dialog --clear --backtitle "$sottotitolo" --msgbox "Verifica prerequisiti OK: pacchetto fsarchiver presente." 5 60
	scelta_operazione
else
        dialog --clear --backtitle "$sottotitolo" --msgbox "Verifica prerequisiti KO: pacchetto fsarchiver mancante." 5 60
        installa_fsarchiver
fi

