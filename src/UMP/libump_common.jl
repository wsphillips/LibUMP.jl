# Types
const StateHandle = Ref{Nothing}

# enums
"""UMP Error enums"""
@cenum Error begin
    NO_ERROR           =  0 # No error
    ERROR_OS_ERROR     = -1 # Operating System level error
    ERROR_NOT_OPEN     = -2 # Communication socket not open
    ERROR_TIMEOUT      = -3 # Timeout occured
    ERROR_INVALID_ARG  = -4 # Illegal command argument
    ERROR_INVALID_DEV  = -5 # Illegal Device Id
    ERROR_INVALID_RESP = -6 # Illegal response received
end

"""Manipulator status enums"""
@cenum Status begin
    STATUS_READ_ERROR =   -1 # Failure at status reading
    STATUS_OK         =    0 # No error and status idle
    STATUS_BUSY       =    1 # Manipulator busy (not necessarily moving)
    STATUS_ERROR      =    8 # Manipulator in error state
    STATUS_X_MOVING   = 0x10 # X-actuator is busy
    STATUS_Y_MOVING   = 0x20 # Y-actuator is busy
    STATUS_Z_MOVING   = 0x40 # Z-actuator is busy
    STATUS_W_MOVING   = 0x80 # 4th actuator is busy
    STATUS_JAMMED     = 0x80 # A manipulator is stuck
end

# constants

const DEF_STORAGE_ID       =     0 # default position storage
const DEF_TIMEOUT          =    20 # default message timeout in millisecods
const DEF_GROUP            =     0 # default manipulator group, group 0 is called 'A' on TCU UI
const MAX_TIMEOUT          =  1000 # maximum message timeout in milliseconds
const MAX_LOG_LINE_LENGTH  =   256 # maximum log message length
const FEATURE_VIRTUALX     =     0 # id number for virtual X axis feature
const MAX_MANIPULATORS     =   254 # Max count of concurrent manipulators supported by this SDK version
const DEF_REFRESH_TIME     =    20 # The default positions refresh period in ms
const MAX_POSITION         = 51000 # The upper absolute position limit for actuators
const TSC_SPEED_MODE_SNAIL =     1 # TSC speed mode for snail mode
const TSC_SPEED_MODE_1     =     2 # TSC speed mode for speed 1
const TSC_SPEED_MODE_2     =     3 # TSC speed mode for speed 2
const TSC_SPEED_MODE_3     =     4 # TSC speed mode for speed 3
const TSC_SPEED_MODE_4     =     5 # TSC speed mode for speed 4
const TSC_SPEED_MODE_5     =     6 # TSC speed mode for speed 5
const TSC_SPEED_MODE_PEN   =     7 # TSC speed mode for penetration
const POS_DRIVE_COMPLETED  =     0 # (memory) position drive completed
const POS_DRIVE_BUSY       =     1 # (memory) position drive busy
const POS_DRIVE_FAILED     =    -1 # (memory) position drive failed
const TIMELIMIT_CACHE_ONLY =     0 # Read position always from the cache
const TIMELIMIT_DISABLED   =    -1 # Skip the internal position cache.
                                   # Use this definition as a parameter to read an actuator position
                                   # directly from a manipulator

const DEF_BCAST_ADDRESS   = "169.254.255.255" # default link-local broadcast address
