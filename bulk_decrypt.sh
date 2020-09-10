#! /bin/bash

usage()
{
    echo "usage: bulk_decrypt [[[-p password ] [-i encrypted filename] [-o decrypted filename] [-f folder]] | [-h]]"
}

###### Main processing

# Process cmd line arguments
password=
encrypted_filename=
decrypted_filename=
folder=
while [ "$1" != "" ]; do
	case $1 in 
		-p | --password )	shift
					password=$1
					;;
		-i | --input )		shift
					encrypted_filename=$1
					;;
		-o | --output )		shift
					decrypted_filename=$1
					;;
		-f | --folder )		shift
					folder=$1
					;;
		-h | --help )		usage
					exit
					;;
		* )			usage
					exit 1
	esac
	shift
done
echo "folder = $folder"	
echo "input file = $encrypted_filename"
echo "output file = $decrypted_filename"
success=
if [[ "$folder" != "" ]]; then
	#shopt -s dotglob globstar
	echo "Performing bulk decryption for files in folder $folder"
	if [[ -d "$folder" ]]; then
		decrypted_folder="$folder/decrypted_files"
		echo "decrypted folder $decrypted_folder"
		mkdir $decrypted_folder
		for input_filename in "$folder"/*; do
			if [[ -f "$input_filename" ]]; then
				input_filename_only="${input_filename##*/}"
				decrypted_filename="$decrypted_folder/$input_filename_only"
				echo "Decrypting $input_filename into $decrypted_filename"
				qpdf --decrypt --password=$password "$input_filename" "$decrypted_filename"
			fi
		done
	else
		echo "$folder is not a directory"
	fi
elif [[ "$encrypted_filename" != "" && "$decrypted_filename" != "" ]]; then
	echo "Attempting to perform decryption for a single file"
	if [[ -r "$encrypted_filename" ]]; then
		echo "Decrypting $encrypted_filename into $decrypted_filename"
		qpdf --decrypt --password=$password "$encrypted_filename" "$decrypted_filename"
	else
		echo "Input file $encrypted_filename is not readable"
	fi
else
	echo "Weird shit happening"
fi
echo "Execution complete"
#echo "You have to specify EITHER a folder containing files to be encrypted OR an input/output file to be decrypted"
