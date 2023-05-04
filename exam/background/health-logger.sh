while true; do
	disk_space=$(bash available_disk_space.sh)
	ram=$(bash available_ram.sh)
	load=$(bash cpu_load.sh)
	temp=$(bash cpu_temp.sh)

	log.sh available_disk_space $((disk_space))
	log.sh available_ram $((ram))
	log.sh cpu_load $((load))
	log.sh cpu_temp $((temp))
	
	sleep 10
done
