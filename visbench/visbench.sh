RESULTDIR=$1
echo "Running YCSB Visualization"

LOADTOCSV()
{

      linenew=${lineouter/sec: /}
      linenew=${linenew/operations; /}
      #linenew=${linenew/operations;/}
      linenew=${linenew/current ops\/sec; /}
      linenew=${linenew/current ops\/sec;/}
      linenew=${linenew/[INSERT AverageLatency(us)=/}
      linenew=${linenew/]/}
      linenew=${linenew/,/.}
      linenew=${linenew/,/.}
      linenew=${linenew/ /,}
      linenew=${linenew/ /,}
      linenew=${linenew/ /,}
      echo $linenew >> throughput.csv
      R CMD BATCH visbench-PlotThroughputLoad.R
      cat throughput.png
}

UPDATETOCSV()
{
      linenew=${lineouter/sec: /}
      linenew=${linenew/operations; /}
      linenew=${linenew/current ops\/sec; /}
      linenew=${linenew/[UPDATE AverageLatency(us)=/}
      linenew=${linenew/]/}
      linenew=${linenew/[READ AverageLatency(us)=/}
      linenew=${linenew/]/}
      linenew=${linenew/,/.}
      linenew=${linenew/,/.}
      linenew=${linenew/,/.}
      linenew=${linenew/ /,}
      linenew=${linenew/ /,}
      linenew=${linenew/ /,}
      linenew=${linenew/ /,}
      echo $linenew >> throughput.csv
      R CMD BATCH visbench-PlotThroughputRun.R
      cat throughput.png
}

while read lineouter
do
  # if monitoring data: trim and plot
  if [[ "$lineouter" =~ ^[1-9] ]]; then
    echo $lineouter
    if (( `expr index "$lineouter" I` != 0 )); then
      workloadtype="load"
      LOADTOCSV $lineouter
    elif (( `expr index "$lineouter" U` != 0 )); then
      workloadtype="run"
      UPDATETOCSV $lineouter
    fi
  # if result data (histograms) persist
  elif [[ "$lineouter" =~ ,.[\>*0-9]+,.[0-9]+ ]]; then
    if [ "$workloadtype" = "load" ]; then
      echo $lineouter >> loadData
    elif [ "$workloadtype" = "run" ] && (( `expr index "$lineouter" U` == 2 )); then
      echo $lineouter >> runDataUpdate
    elif [ "$workloadtype" = "run" ] && (( `expr index "$lineouter" R` == 2 )); then
      echo $lineouter >> runDataRead
    fi
  fi
done

# create result directory
if [ ! -d $RESULTDIR ]; then
  mkdir $RESULTDIR
  mkdir $RESULTDIR/images
fi
# create histograms, plot and store them in RESULTDIR
if [ "$workloadtype" = "load" ]; then
  R CMD BATCH visbench-PlotHistogramLoad.R
  cat YCSBPlotInsert.png
  mv loadData $RESULTDIR/load.csv
elif [ "$workloadtype" = "run" ]; then
  R CMD BATCH visbench-PlotHistogramRun.R
  cat YCSBPlotRun.png
  mv runDataUpdate $RESULTDIR/runDataUpdate.csv
  mv runDataRead $RESULTDIR/runDataRead.csv
fi
mv *.png $RESULTDIR/images/
mv throughput.csv $RESULTDIR/
