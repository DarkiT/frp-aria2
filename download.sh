#!/bin/sh

program_name="frpc"
version="1.7"
str_program_dir=""
download_url="https://code.aliyun.com/clangcn/frp/raw/master"
program_version="0.14.1"
# Check OS bit
check_os_bit(){
    echo "check_os_bit"
    ARCHS=""
    if [[ `getconf WORD_BIT` = '32' && `getconf LONG_BIT` = '64' ]] ; then
        Is_64bit='y'
        ARCHS="amd64"
    else
        Is_64bit='n'
        ARCHS="386"
    fi
}
fun_getVer(){
    echo -e "Loading network version for ${program_name}, please wait..."
    program_latest_filename="frp_${program_version}_linux_${ARCHS}.tar.gz"
    program_latest_file_url="${download_url}/v${program_version}/${program_latest_filename}"
    if [ -z "${program_latest_filename}" ]; then
        echo -e "${COLOR_RED}Load network version failed!!!${COLOR_END}"
    else
        echo -e "${program_name} Latest release file ${COLOR_GREEN}${program_latest_filename}${COLOR_END}"
    fi
}
fun_download_file(){
    # download
	rm -fr ${program_latest_filename} frp_${program_version}_linux_${ARCHS}
	if ! wget --no-check-certificate -q ${program_latest_file_url} -O ${program_latest_filename}; then
		echo -e " ${COLOR_RED}failed${COLOR_END}"
		exit 1
	fi
	tar xzf ${program_latest_filename}
	mv frp_${program_version}_linux_${ARCHS}/${program_name} ${str_program_dir}/${program_name}
	rm -fr ${program_latest_filename} frp_${program_version}_linux_${ARCHS}
    chown root:root -R ${str_program_dir}
    if [ -s ${str_program_dir}/${program_name} ]; then
        [ ! -x ${str_program_dir}/${program_name} ] && chmod 755 ${str_program_dir}/${program_name}
    else
        echo -e " ${COLOR_RED}failed${COLOR_END}"
        exit 1
    fi
}
check_os_bit
fun_getVer
fun_download_file
