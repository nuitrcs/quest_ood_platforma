# Wait for the Platforma server to start
echo "Waiting for Platforma server to open port ${port}..."
echo "TIMING - Starting wait at: $(date)"
if wait_until_port_used "localhost:${port}" 240; then
  echo "Discovered Platforma server listening on port ${port}!"
  echo "TIMING - Wait ended at: $(date)"
  export PLATFORMAURL=`sed -n /Address/p output.log`
  while [[ -z ${PLATFORMAURL} ]]; do
	  export PLATFORMAURL=`sed -n /Address/p output.log`
  done
 # until [ -s output.log ] & [ -n $"sed -n /Address/p output.log" ]; do
 #   sleep 5
 # done
  export PLATFORMAURL=`sed -n /Address/p output.log`
else
  echo "Timed out waiting for Platforma server to open port ${port}!"
  echo "TIMING - Wait ended at: $(date)"
  pkill -P ${SCRIPT_PID}
  clean_up 1
fi

