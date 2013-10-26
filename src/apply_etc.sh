#!/bin/bash
echo "Nadgrywam konfigurację..."
rsync -vr config/* /

echo "Restartuje usługi"

for D in nginx postgresql
	do
		service $D restart
done

