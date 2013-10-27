#!/bin/bash
echo "Nadgrywam konfigurację..."
rsync -vr config/* /

echo "Restartuje usługi"

# TODO: Można by jakoś wykrywać, które usługi restartować
for D in nginx postgresql
	do
		service $D restart
done

