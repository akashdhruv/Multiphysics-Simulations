# cache the value of current directory
NodeDir=$(realpath .)

# Run pre-processing scripts located in the current directory to setup
cd $JobWorkDir && python3 $NodeDir/flashInput.py --input job.input
