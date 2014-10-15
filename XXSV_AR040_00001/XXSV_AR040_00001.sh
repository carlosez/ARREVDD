#
#/*=========================================================================+
#|  Copyright (c) 2014 Entrustca, San Salvador, El Salvador                 |
#|                         ALL rights reserved.                             |
#+==========================================================================+
#|                                                                          |
#| FILENAME                                                                 |
#|     XXSV_AR040_00001.sh                                          |
#|                                                                          |
#| DESCRIPTION                                                              |
#|    Shell Script para la instalacion de parches - Proyecto TIGO         |
#|                                                                          |
#| SOURCE CONTROL                                                           |
#|    Version: %I%                                                          |
#|    Fecha  : %E% %U%                                                      |
#|                                                                          |
#| HISTORY                                                                  |
#|    15-10-2014  Carlos Torres  Created   Entrustca                        |
#+==========================================================================*/

echo ''
echo '                          Oracle LAD eStudio                          '
echo '           Copyright (c) 2012 Entrust San Salvador, El Salvador       '
echo '                        All rights reserved.                          '
echo '       Starting installation process for patch XXSV_AR040_00001       '
echo

# FUNCIONES
read_db_pwd ()
{
    stty -echo # Deshabilito el ECO del Tecladof

    PASSWORD_OK="No"

    while [ "${PASSWORD_OK}" != "Yes" ]
    do
        # Leo la contrasea del usuario de BD
        DB_PASS='' # Inicializo la Variable de Retorno

        while [ -z "${DB_PASS}" ]
        do
            echo -n "Please enter password for $1 user: "
            read DB_PASS
            echo
        
            if [ -z "${DB_PASS}" ]
            then
                echo "The password entered is null."
            fi

        done

        sqlplus -S /nolog <<EOF
whenever sqlerror exit 1
whenever oserror exit 1
conn $1/$DB_PASS
EOF

        if [ "$?" != "0" ]
        then
            echo "The $1 password entered is incorrect."
        else
            PASSWORD_OK="Yes"
        fi
    done

    stty echo # Rehabilito el ECO del Teclado
}

copy_file ()
{
    if [ -f $1/$3 ]
    then
        if [ -f $2/$3 ]
        then
            mv $2/$3 $2/$3_bak$(date +%Y%m%d%H%M%S)
        fi

        cp $1/$3 $2/
    else
        echo "File $1/$3 does not exist"
    fi
}

# COMIENZO DE INSTALACION DEL PARCHE



# Ingreso de la contrasea para el usuario APPS. Usar funcion read_db_pwd $user
read_db_pwd "APPS"
APPS_PASS=$DB_PASS

# Ingreso de la contrasea para el usuario BOLINF. Usar funcion read_db_pwd $user
read_db_pwd "BOLINF"
BOLINF_PASS=$DB_PASS

# Copia de los Objetos. Usar funcion copy_file $origen $destino $file
echo 'Copying objects SQL to $XBOL_TOP'


# Copia de los Imports
echo 'Copying objects LDT to $XBOL_TOP'

#copy_file xbol/admin/import $XBOL_TOP/admin/import XX_AR_REPCAJ_RES.ldt
#copy_file xbol/admin/import $XBOL_TOP/admin/import Receivables_All.ldt
#copy_file xbol/admin/import $XBOL_TOP/admin/import XX_AR_REPCAJ_RES_TMPL.ldt
#copia los  rdfs

#copy_file au/reports $XBOL_TOP/reports/ESA  XX_AP002F930.rdf

# Compilacion de Scripts

echo '------------------------------------------------------------'
echo '                                                            '     
echo '              Installing SQL Data Base Objects              '     
echo '                                                            '  
echo '------------------------------------------------------------'
echo '------------------------------------------------------------'
echo 'Running apps_grants.sql'
sqlplus apps/$APPS_PASS @xbol/sql/apps_grants.sql
echo '------------------------------------------------------------'
echo 'Compiling XXSV_AR_REV_UTL.pks'
sqlplus bolinf/$BOLINF_PASS @xbol/sql/XXSV_AR_REV_UTL.pks
echo '------------------------------------------------------------'
echo 'Compiling XXSV_AR_REV_UTL.pkb'
sqlplus bolinf/$BOLINF_PASS @xbol/sql/XXSV_AR_REV_UTL.pkb
echo '------------------------------------------------------------'
echo 'Creating View XXSV_GL_JE_AR_TRX_CUST_REPORT.sql'
sqlplus bolinf/$BOLINF_PASS @xbol/sql/XXSV_GL_JE_AR_TRX_CUST_REPORT.sql
echo '------------------------------------------------------------'
echo 'Running bolinf_grant.sql'
sqlplus bolinf/$BOLINF_PASS @xbol/sql/bolinf_grant.sql
echo '------------------------------------------------------------'
echo 'Running apps_synonyms.sql'
sqlplus apps/$APPS_PASS @xbol/sql/apps_synonyms.sql
echo '------------------------------------------------------------'


# Carga Concurrentes.
echo '------------------------------------------------------------'
echo '                                                            '     
echo '                   Dumping LDT Definitions                  '
echo '                                                            '  
echo '------------------------------------------------------------'
echo ' '
echo 'Programn C_XXSVARDRILLREV.ldt'
FNDLOAD apps/$APPS_PASS 0 Y UPLOAD $FND_TOP/patch/115/import/afcpprog.lct xbol/admin/import/C_XXSVARDRILLREV.ldt
echo '------------------------------------------------------------'
echo 'Request Group R_Receivables_All.ldt'
FNDLOAD apps/$APPS_PASS 0 Y UPLOAD $FND_TOP/patch/115/import/afcpreqg.lct xbol/admin/import/R_Receivables_All.ldt - CUSTOM_MODE="FORCE"
echo '------------------------------------------------------------'
echo 'Template T_XXSVFACIPADD.ldt '
FNDLOAD apps/$APPS_PASS 0 Y UPLOAD $XDO_TOP/patch/115/import/xdotmpl.lct  xbol/admin/import/T_XXSVARDRILLREV.ldt CUSTOM_MODE="FORCE"
echo ' '
# Carga Template.
echo '------------------------------------------------------------'
echo '                                                            '     
echo '              Instaling BI Publisher Objects                '
echo '                                                            '  
echo '------------------------------------------------------------'
echo ' '
echo 'Moving to directory au/template '
cd au/template
echo '------------------------------------------------------------'
echo ' '
echo 'Loading XML Data Definitions '
echo '------------------------------------------------------------'
echo ' '
XMLPubTemplateExpUpload.sh $APPS_PASS \
    DATA_TEMPLATE \
    XBOL \
    XXSVARDRILLREV \
    00 \
    00 \
    XML-DATA-TEMPLATE \
    XXSVARDRILLREV.xml
    
echo '------------------------------------------------------------'
echo ' '
echo 'Loading RTF Templates '
echo '------------------------------------------------------------'
echo ' '
XMLPubTemplateExpUpload.sh $APPS_PASS \
    TEMPLATE_SOURCE \
    XBOL \
    XXSVARDRILLREV \
    en \
    00 \
    RTF \
    XXSVARDRILLREV.rtf
    
cd ..
cd ..
echo '+----------------------------------------------------------+'
echo '|                                                          |'
echo '|      Installation Complete. Please check log files       |'
echo '|                                                          |'
echo '+----------------------------------------------------------+'

