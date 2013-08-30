== DEPENDENCIES ==
	* YCSB-Installation + zu testende Cloudumgebung (getestet nur mit Cassandra)
	* R inkl. package "zoo"
	* GateOne + Ausführung in GateOne Terminal (Ausgabe von Bildern mit "cat")

== AUFBAU/FILES ==
	* Hauptdatei: visbench.sh
	* R-Scripts zum Erzeugen der Grafiken: visbench-PlotThroughputLoad.R, visbench-PlotThroughputRun.R, visbench-PlotHistogramLoad.R, visbench-PlotHistogramRun.R

== IDEE ==
	* Das Script Verarbeitet die Ausgaben von ycsb, die in stderr und stdout geschrieben werden, indem die interessierenden Durchsatz-Metriken herausgefiltert und visualisiert werden.

== AUFRUF ==
	* Das Script wird innerhalb einer Pipe aufgerufen, d.h. an den Aufruf von ycsb angehängt. So bleiben für den Nutzer alle Parameter von ycsb transparent.
	* Damit alle wichtigen Daten (Echtzeit) visualisiert werden können, muss stderr umgeleitet werden
	* der Aufruf sieht wie folgt aus: pfad/ycsb [load|run] [ycsb-parameter] 2>&1 | pfad/visbench.sh [Pfad Speicherort Ausgabe]
	* Bei jeder Ausführung werden die Dateien im Zielordner überschrieben.
	* Bsp. eines Aufrufs: 
		- Load: ycsb-0.1.4/bin/ycsb load cassandra-10 -P ycsb-0.1.4/workloads/workloada -s -threads 10 -p recordcount=150000 -p histogram.buckets=10 -p 2>&1 | pfad/visbench.sh ~/benchmark_results/visbench
		- Run: ycsb-0.1.4/bin/ycsb run cassandra-10 -P ycsb-0.1.4/workloads/workloada -s -threads 10 -p recordcount=150000 -p operationcount=150000 -p histogram.buckets=10 -p 2<&1 | pfad/visbench.sh ~/benchmark_results/visbench


== ERGEBNIS ==
	* Das Script erzeugt für jede von ycsb Eintreffende Statusmeldung eine Grafik. Es treffen nur alle 10 Sekunden Statusmeldungen ein. Zudem entsteht in GateOne manchmal eine Verzögerung beim Laden/Anzeigen der Grafik. Es dauert also ein paar Sekunden bis die erste Grafik erscheint.
	* Wenn man alle zur Verfügung stehenden Daten visualisieren möchte, wird die Grafik etwas zu breit und im Terminal wird nur eine verkleinerte Version dargestellt. Diese kann aber zum Vergrößern angeklickt werden.
	* Es wird keine animierte Grafik erzeugt, sondern eine Folge von Grafiken.
	* Am Ende des Durchlaufs wird ein Histogramm für die Latenzen der einzelnen Operationen erzeugt.
	* Folgende Dateien befinden sich in dem Ordner, der als Parameter übergeben wurde:
		- throughput.csv: Durchsatz-Daten. Format: zeit, operations, ops/sec, latency (, latency) --> In der "run" Phase werden Latenzen für READ und UPDATE Operationen separat gemessen
		- load.csv ODER (runDataUpdate.csv UND runDataRead.csv): Histogramm-Daten
		- /images: throughput.png: Vollständige Zeitreihen der Durchsatzmetriken. YCSBPlotRun.png ODER YCSBPlotLoad.png: Histogramme.
