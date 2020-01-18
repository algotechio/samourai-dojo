#########################################
# CONFIGURATION OF ELECTRS CONTAINER
#########################################


# Install and run a electrs inside Dojo (recommended)
# Value: on | off
ELECTRS_INSTALL=on


# Additional parameters to run electrs command.  Useful if you need to run need
# to run on platform with limited resources
# Recommended setting for Raspberry Pi:  
ELECTRS_OPTIONS=--index-batch-size=10 

