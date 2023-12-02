#1 bin/bash
taxa=0
opcja1=0

dodaj()
{ 
 sed -i "/$ryba/s/$/$value/" base.txt
}
zamien()
{ wzorlini="$ryba"
  sed -i "/$wzorlini/{s/$parameter[^ ]*/$value/}" base.txt

}
usun()
{ wzorlini="$ryba"
 sed -i "/$wzorlini/{s/$value//}" base.txt
}

ryba=("$1")
opcja=0
while ((opcja!=5)); do           
echo "         
███╗░░░███╗██╗░░░██╗███████╗██╗░██████╗██╗░░██╗██████╗░░█████╗░░██████╗███████╗
████╗░████║╚██╗░██╔╝██╔════╝██║██╔════╝██║░░██║██╔══██╗██╔══██╗██╔════╝██╔════╝
██╔████╔██║░╚████╔╝░█████╗░░██║╚█████╗░███████║██████╦╝███████║╚█████╗░█████╗░░
██║╚██╔╝██║░░╚██╔╝░░██╔══╝░░██║░╚═══██╗██╔══██║██╔══██╗██╔══██║░╚═══██╗██╔══╝░░
██║░╚═╝░██║░░░██║░░░██║░░░░░██║██████╔╝██║░░██║██████╦╝██║░░██║██████╔╝███████╗
╚═╝░░░░░╚═╝░░░╚═╝░░░╚═╝░░░░░╚═╝╚═════╝░╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═════╝░╚══════╝               
                  ------------------------------------
                  |   1.dodaj rybe                   | <><  
                  |   2.szukaj wedlug parametrow     |   <><   
                  |   3.usun rybe                    |  <><  <>< 
                  |   4.zmien parametry ryby         |     <>< 
                  |   5.wyjdz                        |  <><  
                  ------------------------------------   <><  <>< 
                                                       <>< "
read opcja
clear
case $opcja in
'1') echo "podaj nazwe ryby <>< " 
    read ryba
  result=$(grep "$ryba" base.txt)
   if [ -z "$result" ]; then
   echo "$ryba" >> base.txt
   else
   echo "ta ryba jest juz w bazie"r
   fi
;;
'2')echo "ile fraz chcesz wyszukać w jednym zapytaniu?"
    read n
   ask=()
   for ((i=0;i<n;i++)) 
   do
   echo "wpisz fraze do wyszukania"
   read ask[$i]
   done
  
   echo "ile parametrów chcesz pokazać dla wyszukanych ryb?"
   read m
   par=()
   for ((i=0;i<m;i++)) 
   do
   echo "wpisz parametr który chcesz wyswietlic
         dostępne to:
         -family
         -order
         -highertaxa
         -distribution
         -size
         -weight
         -engname
         -planme
         -maxsize
         -lifespan
         -maxweight
         -info 
           "
   read par[$i]
   done

   for ((i=0;i<n;i++))
   do 
     if ((i==0))
    then 
        result=$(grep "${ask[i]}" base.txt)
        echo "$result" >helpfile.txt
    else 
       result=$(grep "${ask[i]}" helpfile.txt)
       echo "$result">helpfile.txt
    fi 
   done
  for ((i=0;i<m;i++))
  do
   grepask+="| ${par[i]}:{[^}]*}"
  done 
  clear
   grep -oE "^\w+\s+\w+|$grepask" helpfile.txt 
   read key
;;
'3') echo "podaj nazwę ryby którą chcesz usunąć"
     read ryba
     sed -i "/$ryba/d" base.txt
;;
'4') echo "wpisz rybe"
     read ryba
     opcja1=0
     result=$(grep "$ryba" base.txt)
   if [ -z "$result" ]; then
   
   echo "takiej ryby nie ma w bazie"
   opcja1=16
   fi
     while ((opcja1!=16)); do     
     echo " 
              -------------------------------
              |  wybierz parametr           | <>< 
              | 1. rodzina                  |   <>< 
              | 2. rząd                     | <><  <>< 
              | 3. wyższe taksony           |  <>< 
              | 4. występowanie             |
              | 5. rozmiar                  |   <>< 
              | 6. waga                     |
              | 7. nazwa angielska          | <><  <>< 
              | 8. nazwa polska             |  <>< 
              | 9. data dodania             |
              |10. glebokosc wystepowania   |  <>< 
              |11. maksymalny rozmiar       |
              |12. maksymalna waga          |
              |13. dlugosc zycia            |
              |14. dodatkowe informacje     |
              |15. red list status          |
              |16. wyjdz                    |
              -------------------------------
"   
      grep "$ryba" base.txt

      read opcja1
     case $opcja1 in 
       '1') echo "1-dodaj, 2-zamien, 3-usun" #----------------------------------------------------------------------------------------
            read operacja
              case $operacja in
              '1') echo "wpisz rodzine lub x aby anulowac"
                   read rodzina 
                   if [ rodzina == "x" ]
                   then break  
                   fi 
                   value=" family:{$rodzina}"
                   dodaj 
                ;;
               '2')  echo "wpisz rodzine lub x aby anulowac"
                     read rodzina
                     if [ rodzina == "x" ] 
                     then break  
                      fi 
                     value=" family:{$rodzina}"
                     parameter=" family:"
                     zamien                   
              ;;
              '3')   echo "wpisz rodzine do usunięcia lub x aby anulowac"
                     read rodzina
                     if [ rodzina == "x" ]  
                     then break  
                      fi 
                     value="family:{$rodzina}"
                     usun
              ;;
              esac
        ;; #--------------------------------------------------------------------------------------------------------------------- 
       '2') echo "1-dodaj, 2-zamien, 3-usun" 
            read operacja
              case $operacja in
              '1') echo "wpisz rząd lub x aby anulowac"
                   read order 
                   if [ order == "x" ] 
                     then break  
                      fi 
                   value=" order:{$order}"
                   dodaj 
                ;;
               '2')  echo "wpisz rzad lub x aby anulowac"
                     read order
                     if [ order == "x" ] 
                     then break  
                      fi 
                     value=" order:{$order}"
                     parameter=" order:"
                     zamien                  
               ;;
              '3') echo "wpisz rybe"
                   read ryba[0] ryba[1]
                    echo "wpisz rzad do usunięcia lub x aby anulowac"
                    if [ order == "x" ] 
                     then break  
                      fi 
                     read order
                     value="order:{$order}"
                     usun
               ;;
              esac
         ;; #-------------------------------------------------------------------------------------------------------------------
         '3') echo "1-dodaj, 2-usun"
              read operacja
              case $operacja in
               '1') echo "wpisz takson lub x aby anulowac"
                   read taxa
                   if [ taxa == "x" ]  
                   then break  
                   fi 
                   value=" highertaxa:{$taxa}"
                   dodaj 
                  
                ;;
               '2')  echo "wpisz takson do usunięcia lub x aby anulowac"
                     read taxa
                     if [ taxa == "x" ]  
                     then break  
                     fi 
                     value="highertaxa:{$taxa}"
                     usun

               ;;
               esac
         ;; #--------------------------------------------------------------------------------------------------------------------
         '4')echo "1-dodaj, 2-usun"
             read operacja
             case $operacja in
             '1') echo "wpisz miejsce występowania lub x aby anulowac"
                  read distribution 
                  if [ distribution == "x" ] 
                  then break  
                  fi 
                  value=" distribution:{$distribution}"
                  dodaj
              ;;
              '2')
                  echo "wpisz miejsce wystepowania do usuniecia lub x aby anulowac"
                  read distribution
                  if [ distribution == "x" ] 
                  then break  
                  fi 
                  value="distribution:{$distribution}"
                  usun
              ;;
             esac
           
         ;; #--------------------------------------------------------------------------------------------------------------------
         '5')  echo "1-dodaj,2-zamien, 3-usun"
               read operacja
               case $operacja in
               '1') 
                    echo "wpisz rozmiar ryby w cm lub x aby anulowac"
                    read size
                    if [ size == "x" ] 
                    then break  
                    fi 
                    value=" size:{$size}"
                    dodaj
                ;;
               '2')  
                     echo "wpisz rozmiar ryby w cm lub x aby anulowac"
                     read size
                     if [ size == "x" ]
                     then break  
                      fi 
                     value=" size:{$size}"
                     parameter=" size:"
                     zamien 
               ;;
               '3')
                   echo "wpisz rozmiar do usuniecia lub x aby anulowac"
                   read size
                  if [ size == "x" ]
                  then break  
                  fi 
                  value="size:{$size}"
                  usun
               ;;
               esac
         ;; #-----------------------------------------------------------------------------------------------------------------------
         '6')  echo "1-dodaj,2-zamien, 3-usun"
               read operacja
               case $operacja in
               '1')  
                    echo "wpisz wage ryby w g lub x aby anulowac"
                    read weight
                    if [ weight == "x" ]
                    then break  
                    fi 
                    value=" weight:{$weight}"
                    dodaj
                ;;
               '2')  
                     echo "wpisz wage ryby w g lub 0 aby anulowac"
                     read weight
                     if [ weight == "x" ]
                     then break  
                      fi 
                     value=" weight:{$weight}"
                     parameter=" weight:"
                     zamien 
               ;;
               '3')
                   echo "wpisz wage ryby do usuniecia lub 0 aby anulowac"
                   read weight
                  if [ weight == "x" ]
                  then break  
                  fi 
                  value="weight:{$weight}"
                  usun
               ;;
               esac
         ;; #------------------------------------------------------------------------------------------------------------------------
         '7')echo "1-dodaj, 2-usun"
             read operacja
             case $operacja in
             '1') 
                  echo "wpisz angielska nazwe lub x aby anulowac"
                  read engname
                  if [ engname == "x" ]
                  then break   
                  fi 
                  value=" engname:{$engname}"
                  dodaj
              ;;
              '2')
                  echo "wpisz angielska nazwe do usuniecia lub x aby anulowac"
                  read engname
                  if [ engname == "x" ]
                  then break  
                  fi 
                  value="engname:{$engname}"
                  usun
              ;;
             esac
         ;; #----------------------------------------------------------------------------------------------------------------------------
        '8') echo "1-dodaj, 2-usun"
             read operacja
             case $operacja in
             '1') 
                  echo "wpisz polska nazwe lub x aby anulowac"
                  read plname
                  if [ plname == "x" ]
                  then break   
                  fi 
                  value=" plname:{$plname}"
                  dodaj
              ;;
              '2')
                  echo "wpisz polska nazwe do usuniecia lub x aby anulowac"
                  read plname
                  if [ plname == "x" ]
                  then break  
                  fi 
                  value="plname:{$plname}"
                  usun
              ;;
              esac
         ;; #-----------------------------------------------------------------------------------------------------------------------------
         '9')echo "1-dodaj,2-zamien, 3-usun"
               read operacja
               case $operacja in
               '1') 
                    echo "wpisz date dodania ryby  lub x aby anulowac"
                    read date
                    if [ date == "x" ]
                    then break  
                    fi 
                    value=" date:{$date}"
                    dodaj
                ;;
               '2')  
                     echo "wpisz date dodania ryby  lub x aby anulowac"
                     read date
                     if [ date == "x" ]
                     then break  
                      fi 
                     value=" date:{$date}"
                     parameter=" date:"
                     zamien 
               ;;
               '3') 
                   echo "wpisz date dodania ryby do usuniecia lub x aby anulowac"
                   read date
                  if [ date == "x" ]
                  then break  
                  fi 
                  value="date:{$date}"
                  usun
               ;;
               esac
              
         ;; #------------------------------------------------------------------------------------------------------------------------------
         '10')echo "1-dodaj,2-zamien, 3-usun"
               read operacja
               case $operacja in
               '1')
                    echo "wpisz glebokosc w m lub x aby anulowac"
                    read deep
                    if [ deep == "x" ]
                    then break  
                    fi  
                    value=" depth:{$deep}"
                    dodaj
                ;;
               '2')  
                     echo "wpisz glebokosc w m lub x aby anulowac"
                     read deep
                     if [ deep == "x" ]
                     then break  
                      fi 
                     value=" depth:{$deep}"
                     parameter=" depth:"
                     zamien 
               ;;
               '3')
                   echo "wpisz glebokosc do usuniecia lub x aby anulowac"
                   read deep
                  if [ deep == "x" ]
                  then break  
                  fi 
                  value="depth:{$deep}"
                  usun
               ;;
               esac
         ;; #------------------------------------------------------------------------------------------------------------------------------
         '11')echo "1-dodaj,2-zamien, 3-usun"
               read operacja
               case $operacja in
               '1')  
                    echo "wpisz rozmiar ryby w cm lub x aby anulowac"
                    read maxsize
                    if [ maxsize == "x" ] 
                    then break  
                    fi 
                    value=" maxsize:{$maxsize}"
                    dodaj
                ;;
               '2')  
                     echo "wpisz rozmiar ryby w cm lub x aby anulowac"
                     read maxsize
                     if [ maxsize == "x" ]  
                     then break  
                      fi 
                     value=" maxsize:{$maxsize}"
                     parameter=" maxsize:"
                     zamien 
               ;;
               '3') 
                   echo "wpisz rozmiar do usuniecia lub x aby anulowac"
                   read maxsize
                  if [ maxsize == "x" ]  
                  then break  
                  fi 
                  value="maxsize:{$maxsize}"
                  usun
               ;;
               esac
         ;; #------------------------------------------------------------------------------------------------------------------------------
         '12') echo "1-dodaj,2-zamien, 3-usun"
               read operacja
               case $operacja in
               '1') 
                    echo "wpisz wage ryby w g lub x aby anulowac"
                    read maxweight
                    if [ maxweight == "x" ]  
                    then break  
                    fi 
                    value=" maxweight:{$maxweight}"
                    dodaj
                ;;
               '2')  
                     echo "wpisz wage ryby w g lub x aby anulowac"
                     read maxweight
                     if [ maxweight == "x" ] 
                     then break  
                      fi 
                     value=" maxweight:{$maxweight}"
                     parameter=" maxweight:"
                     zamien 
               ;;
               '3')
                   echo "wpisz wage ryby do usuniecia lub x aby anulowac"
                   read maxweight
                  if [ maxweight == "x" ]
                  then break  
                  fi 
                  value="maxweight:{$maxweight}"
                  usun
               ;;
               esac
         ;; #--------------------------------------------------------------------------------------------------------------------------------
         '13')echo "1-dodaj,2-zamien, 3-usun"
               read operacja
               case $operacja in
               '1') 
                    echo "wpisz dlugosc zycia ryby w latach lub x aby anulowac"
                    read lifespan
                    if [ lifespan == "x" ]  
                    then break  
                    fi 
                    value=" lifespan:{$lifespan}"
                    dodaj
                ;;
               '2') 
                     echo "wpisz dlugosc zycia ryby w latach lub x aby anulowac"
                     read lifespan
                     if [ lifespan == "x" ] 
                     then break  
                      fi 
                     value=" lifespan:{$lifespan}"
                     parameter=" lifespan:"
                     zamien 
               ;;
               '3')
                   echo "wpisz dlugosc zycia ryby do usuniecia lub x aby anulowac"
                   read lifespan
                  if [ lifespan == "x" ]
                  then break  
                  fi 
                  value="lifespan:{$lifespan}"
                  usun
               ;;
               esac
         ;; #-------------------------------------------------------------------------------------------------------------------------------
         '14') 
               echo "1-dodaj tresc, 2-usun tresc"
               read opcja
               case $opcja in
               '1') echo "wpisz informacje ktora chcesz dodac lub x aby anulowac"
                    read tresc
                    if [ tresc == "x" ]
                    then break  
                    fi 
                    value=" info:{$tresc}"
                    dodaj
                ;;  
                '2')echo "wpisz informacje ktora chcesz usunac lub x aby anulowac"
                    read tresc
                    if [ tresc == "x" ]
                    then break  
                    fi 
                    value="info:{$tresc}"
                    usun
                ;;
               esac
         ;; #------------------------------------------------------------------------------------------------------------------------------
         '15')echo "1-dodaj, 2-usun"
               read opcja
               case $opcja in
               '1') echo "wpisz status lub x aby anulowac"
                    read stat
                    if [ stat == "x" ]
                    then break  
                    fi 
                    value=" status:{$stat}"
                    dodaj
                ;;  
                '2')echo "wpisz status lub x aby anulowac"
                    read stat
                    if [ stat == "x" ]
                    then break  
                    fi 
                    value="status:{$stat}"
                    usun
                ;;
               esac
         ;; #---------------------------------------------------------------------------------------------------------------------------
       esac
       done
;; #-------------------------------------------------------------------------------------------------------------------------------------------
esac

done
