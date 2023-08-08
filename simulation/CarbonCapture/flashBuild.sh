# cache the value of current working directory
NodeDir=$(realpath .)

ExternalSimName="incompFlow/FlashExternal"

# Link private simulation directory
rm -r $FLASHX_HOME/source/Simulation/SimulationMain/$ExternalSimName
ln -s $NodeDir $FLASHX_HOME/source/Simulation/SimulationMain/$ExternalSimName 

# run Flash-X setup
cd $FLASHX_HOME && ./setup $ExternalSimName $FlashOptions
