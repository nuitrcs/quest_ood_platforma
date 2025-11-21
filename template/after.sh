# Wait for the Platforma server to start
echo "Waiting for Platforma server to open port ${port}..."
echo "TIMING - Starting wait at: $(date)"
if wait_until_port_used "localhost:${port}" 240; then
  echo "Discovered Platforma server listening on port ${port}!"
  echo "TIMING - Wait ended at: $(date)"
  until grep -q Address output.log; do
    sleep 5
  done
  export platformaurl=`cat output.log | grep Address`
else
  echo "Timed out waiting for Platforma server to open port ${port}!"
  echo "TIMING - Wait ended at: $(date)"
  pkill -P ${SCRIPT_PID}
  clean_up 1
fi

