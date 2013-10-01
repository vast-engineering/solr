# Common functions etc. used by startService and stopService

# Define service specific values.
SERVICE_NAME="Search Index"
SERVICE_ID=search-index

# Apply the operator passed as the first argument to each of the remaining
# arguments in turn till one returns true. Evaluates to the value of the
# first argument that returns true.
findDirectory()
{
 local L OP=$1
 shift
 for L in "$@"; do
   [ "$OP" "$L" ] || continue
   printf %s "$L"
   break
 done
}

# Call with the name of a file containing a process id. Check whether the file exists (return 1 if it doesn't)
# and if it does use kill -0 to check if the process in the file is running, returning 0 if it is, 1 if it's not.
running()
{
 local PID=$(cat "$1" 2>/dev/null) || return 1
 kill -0 "$PID" 2>/dev/null
}

# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ] ; do
 ls=`ls -ld "$PRG"`
 link=`expr "$ls" : '.*-> \(.*\)$'`
 if expr "$link" : '/.*' > /dev/null; then
   PRG="$link"
 else
   PRG=`dirname "$PRG"`/"$link"
 fi
done

PRGDIR=`dirname "$PRG"`

# Set the configuration directory to the default location if not already set
if [ -z "$CNFDIR" ]
then
  CNFDIR=${PRGDIR}/config
fi

# Set tmp if not already set.
TMPDIR=${TMPDIR:-/tmp}

# Find a location for the pid file
if [ -z "$SERVICE_RUN" ]
then
# Find first writable directory out of the provided list
 SERVICE_RUN=$(findDirectory -w /var/run/${SERVICE_ID} ./)
fi

# Choose the name for the pid file
if [ -z "$SERVICE_PID" ]
then
 SERVICE_PID="${SERVICE_RUN}/${SERVICE_ID}.pid"
fi

# Set JAVA variable if unset
if [ -z "$JAVA" ]
then
 JAVA=$(which java)
fi

if [ -z "$JAVA" ]
then
 echo "Cannot find a Java JDK. Please set either set JAVA or put java (>=1.6) in your PATH." 2>&2
 exit 1
fi
