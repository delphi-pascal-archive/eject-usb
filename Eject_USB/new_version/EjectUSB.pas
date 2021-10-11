unit EjectUSB;

interface

uses
    Windows, SysUtils, Classes, Dialogs, ShlObj;

const
{    BusTypeUnknown                      = $0000;
    BusTypeScsi                         = $0001;}
    BusTypeAtapi                        = $0002;
    BusTypeAta                          = $0003;
    BusType1394                         = $0004;
{    BusTypeSsa                          = $0005;
    BusTypeFibre                        = $0006;}
    BusTypeUsb                          = $0007;
{    BusTypeRAID                         = $0008;
    BusTypeiSCSI                        = $0009;
    BusTypeSas                          = $000A;
    BusTypeSata                         = $000B;
    BusTypeSd                           = $000C;
    BusTypeMmc                          = $000D;
    BusTypeMax                          = $000E;
    BusTypeMaxReserved                  = $007F;}

    PNP_VetoTypeUnknown                 = $0000;
{    PNP_VetoLegacyDevice                = $0001;
    PNP_VetoPendingClose                = $0002;
    PNP_VetoWindowsApp                  = $0003;
    PNP_VetoWindowsService              = $0004;
    PNP_VetoOutstandingOpen             = $0005;
    PNP_VetoDevice                      = $0006;
    PNP_VetoDriver                      = $0007;
    PNP_VetoIllegalDeviceRequest        = $0008;
    PNP_VetoInsufficientPower           = $0009;
    PNP_VetoNonDisableable              = $000A;
    PNP_VetoLegacyDriver                = $000B;
    PNP_VetoInsufficientRights          = $000C;}

    CR_SUCCESS                  = $00000000;
{    CR_DEFAULT                  = $00000001;
    CR_OUT_OF_MEMORY            = $00000002;
    CR_INVALID_POINTER          = $00000003;
    CR_INVALID_FLAG             = $00000004;
    CR_INVALID_DEVNODE          = $00000005;
    CR_INVALID_DEVINST          = CR_INVALID_DEVNODE;
    CR_INVALID_RES_DES          = $00000006;
    CR_INVALID_LOG_CONF         = $00000007;
    CR_INVALID_ARBITRATOR       = $00000008;
    CR_INVALID_NODELIST         = $00000009;
    CR_DEVNODE_HAS_REQS         = $0000000A;
    CR_DEVINST_HAS_REQS         = CR_DEVNODE_HAS_REQS;
    CR_INVALID_RESOURCEID       = $0000000B;
    CR_DLVXD_NOT_FOUND          = $0000000C;   // WIN 95 ONLY
    CR_NO_SUCH_DEVNODE          = $0000000D;
    CR_NO_SUCH_DEVINST          = CR_NO_SUCH_DEVNODE;
    CR_NO_MORE_LOG_CONF         = $0000000E;
    CR_NO_MORE_RES_DES          = $0000000F;
    CR_ALREADY_SUCH_DEVNODE     = $00000010;
    CR_ALREADY_SUCH_DEVINST     = CR_ALREADY_SUCH_DEVNODE;
    CR_INVALID_RANGE_LIST       = $00000011;
    CR_INVALID_RANGE            = $00000012;
    CR_FAILURE                  = $00000013;
    CR_NO_SUCH_LOGICAL_DEV      = $00000014;
    CR_CREATE_BLOCKED           = $00000015;
    CR_NOT_SYSTEM_VM            = $00000016;   // WIN 95 ONLY
    CR_REMOVE_VETOED            = $00000017;
    CR_APM_VETOED               = $00000018;
    CR_INVALID_LOAD_TYPE        = $00000019;
    CR_BUFFER_SMALL             = $0000001A;
    CR_NO_ARBITRATOR            = $0000001B;
    CR_NO_REGISTRY_HANDLE       = $0000001C;
    CR_REGISTRY_ERROR           = $0000001D;
    CR_INVALID_DEVICE_ID        = $0000001E;
    CR_INVALID_DATA             = $0000001F;
    CR_INVALID_API              = $00000020;
    CR_DEVLOADER_NOT_READY      = $00000021;
    CR_NEED_RESTART             = $00000022;
    CR_NO_MORE_HW_PROFILES      = $00000023;
    CR_DEVICE_NOT_THERE         = $00000024;
    CR_NO_SUCH_VALUE            = $00000025;
    CR_WRONG_TYPE               = $00000026;
    CR_INVALID_PRIORITY         = $00000027;
    CR_NOT_DISABLEABLE          = $00000028;
    CR_FREE_RESOURCES           = $00000029;
    CR_QUERY_VETOED             = $0000002A;
    CR_CANT_SHARE_IRQ           = $0000002B;
    CR_NO_DEPENDENT             = $0000002C;
    CR_SAME_RESOURCES           = $0000002D;
    CR_NO_SUCH_REGISTRY_KEY     = $0000002E;
    CR_INVALID_MACHINENAME      = $0000002F;   // NT ONLY
    CR_REMOTE_COMM_FAILURE      = $00000030;   // NT ONLY
    CR_MACHINE_UNAVAILABLE      = $00000031;   // NT ONLY
    CR_NO_CM_SERVICES           = $00000032;   // NT ONLY
    CR_ACCESS_DENIED            = $00000033;   // NT ONLY
    CR_CALL_NOT_IMPLEMENTED     = $00000034;
    CR_INVALID_PROPERTY         = $00000035;
    CR_DEVICE_INTERFACE_ACTIVE  = $00000036;
    CR_NO_SUCH_DEVICE_INTERFACE = $00000037;
    CR_INVALID_REFERENCE_STRING = $00000038;
    CR_INVALID_CONFLICT_LIST    = $00000039;
    CR_INVALID_INDEX            = $0000003A;
    CR_INVALID_STRUCTURE_SIZE   = $0000003B;
    NUM_CR_RESULTS              = $0000003C;}

{    FILE_DEVICE_BEEP                = $00000001;
    FILE_DEVICE_CD_ROM              = $00000002;
    FILE_DEVICE_CD_ROM_FILE_SYSTEM  = $00000003;
    FILE_DEVICE_CONTROLLER          = $00000004;
    FILE_DEVICE_DATALINK            = $00000005;
    FILE_DEVICE_DFS                 = $00000006;
    FILE_DEVICE_DISK                = $00000007;
    FILE_DEVICE_DISK_FILE_SYSTEM    = $00000008;
    FILE_DEVICE_FILE_SYSTEM         = $00000009;
    FILE_DEVICE_INPORT_PORT         = $0000000a;
    FILE_DEVICE_KEYBOARD            = $0000000b;
    FILE_DEVICE_MAILSLOT            = $0000000c;
    FILE_DEVICE_MIDI_IN             = $0000000d;
    FILE_DEVICE_MIDI_OUT            = $0000000e;
    FILE_DEVICE_MOUSE               = $0000000f;
    FILE_DEVICE_MULTI_UNC_PROVIDER  = $00000010;
    FILE_DEVICE_NAMED_PIPE          = $00000011;
    FILE_DEVICE_NETWORK             = $00000012;
    FILE_DEVICE_NETWORK_BROWSER     = $00000013;
    FILE_DEVICE_NETWORK_FILE_SYSTEM = $00000014;
    FILE_DEVICE_NULL                = $00000015;
    FILE_DEVICE_PARALLEL_PORT       = $00000016;
    FILE_DEVICE_PHYSICAL_NETCARD    = $00000017;
    FILE_DEVICE_PRINTER             = $00000018;
    FILE_DEVICE_SCANNER             = $00000019;
    FILE_DEVICE_SERIAL_MOUSE_PORT   = $0000001a;
    FILE_DEVICE_SERIAL_PORT         = $0000001b;
    FILE_DEVICE_SCREEN              = $0000001c;
    FILE_DEVICE_SOUND               = $0000001d;
    FILE_DEVICE_STREAMS             = $0000001e;
    FILE_DEVICE_TAPE                = $0000001f;
    FILE_DEVICE_TAPE_FILE_SYSTEM    = $00000020;
    FILE_DEVICE_TRANSPORT           = $00000021;
    FILE_DEVICE_UNKNOWN             = $00000022;
    FILE_DEVICE_VIDEO               = $00000023;
    FILE_DEVICE_VIRTUAL_DISK        = $00000024;
    FILE_DEVICE_WAVE_IN             = $00000025;
    FILE_DEVICE_WAVE_OUT            = $00000026;
    FILE_DEVICE_8042_PORT           = $00000027;
    FILE_DEVICE_NETWORK_REDIRECTOR  = $00000028;
    FILE_DEVICE_BATTERY             = $00000029;
    FILE_DEVICE_BUS_EXTENDER        = $0000002a;
    FILE_DEVICE_MODEM               = $0000002b;
    FILE_DEVICE_VDM                 = $0000002c;
    FILE_DEVICE_MASS_STORAGE        = $0000002d;
    FILE_DEVICE_SMB                 = $0000002e;
    FILE_DEVICE_KS                  = $0000002f;
    FILE_DEVICE_CHANGER             = $00000030;
    FILE_DEVICE_SMARTCARD           = $00000031;
    FILE_DEVICE_ACPI                = $00000032;
    FILE_DEVICE_DVD                 = $00000033;
    FILE_DEVICE_FULLSCREEN_VIDEO    = $00000034;
    FILE_DEVICE_DFS_FILE_SYSTEM     = $00000035;
    FILE_DEVICE_DFS_VOLUME          = $00000036;}

    DIGCF_PRESENT                       = $00000002;
    DIGCF_DEVICEINTERFACE               = $00000010;

    GUID_DEVINTERFACE_FLOPPY    : TGUID = (D1:$53f56311;D2:$b6bf;D3:$11d0;D4:($94,$f2,$00,$a0,$c9,$1e,$fb,$8b));
    GUID_DEVINTERFACE_DISK      : TGUID = (D1:$53f56307;D2:$b6bf;D3:$11d0;D4:($94,$f2,$00,$a0,$c9,$1e,$fb,$8b));
    GUID_DEVINTERFACE_CDROM     : TGUID = (D1:$53f56308;D2:$b6bf;D3:$11d0;D4:($94,$f2,$00,$a0,$c9,$1e,$fb,$8b));

    IOCTL_STORAGE_GET_DEVICE_NUMBER     = (($0000002d shl 16) or ($0000 shl 14) or ($0420 shl 2) or 0);
    IOCTL_STORAGE_GET_HOTPLUG_INFO      = (($0000002d shl 16) or ($0000 shl 14) or ($0305 shl 2) or 0);
    IOCTL_STORAGE_MEDIA_REMOVAL         = (($0000002d shl 16) or ($0001 shl 14) or ($0201 shl 2) or 0);
    IOCTL_STORAGE_EJECT_MEDIA           = (($0000002d shl 16) or ($0001 shl 14) or ($0202 shl 2) or 0);
    IOCTL_STORAGE_CHECK_VERIFY          = (($0000002d shl 16) or ($0001 shl 14) or ($0200 shl 2) or 0);
    IOCTL_STORAGE_EJECTION_CONTROL      = (($0000002d shl 16) or ($0000 shl 14) or ($0250 shl 2) or 0);
    IOCTL_STORAGE_QUERY_PROPERTY        = (($0000002d shl 16) or ($0000 shl 14) or ($0500 shl 2) or 0);
{    IOCTL_STORAGE_SET_HOTPLUG_INFO      = (($0000002d shl 16) or (($0001 or $0002) shl 14) or ($0306 shl 2) or 0);
    IOCTL_STORAGE_LOAD_MEDIA            = (($0000002d shl 16) or ($0001 shl 14) or ($0203 shl 2) or 0);
    IOCTL_STORAGE_RESERVE               = (($0000002d shl 16) or ($0001 shl 14) or ($0204 shl 2) or 0);
    IOCTL_STORAGE_RELEASE               = (($0000002d shl 16) or ($0001 shl 14) or ($0205 shl 2) or 0);
    IOCTL_STORAGE_FIND_NEW_DEVICES      = (($0000002d shl 16) or ($0001 shl 14) or ($0206 shl 2) or 0);
    IOCTL_STORAGE_GET_MEDIA_TYPES       = (($0000002d shl 16) or ($0000 shl 14) or ($0300 shl 2) or 0);
    IOCTL_STORAGE_GET_MEDIA_TYPES_EX    = (($0000002d shl 16) or ($0000 shl 14) or ($0301 shl 2) or 0);
    IOCTL_STORAGE_RESET_BUS             = (($0000002d shl 16) or ($0001 shl 14) or ($0400 shl 2) or 0);
    IOCTL_STORAGE_RESET_DEVICE          = (($0000002d shl 16) or ($0001 shl 14) or ($0401 shl 2) or 0);}

    FSCTL_LOCK_VOLUME                   = (($00000009 shl 16) or ($0000 shl 14) or (00006 shl 2) or 0);
    FSCTL_DISMOUNT_VOLUME               = (($00000009 shl 16) or ($0000 shl 14) or (00008 shl 2) or 0);
    FSCTL_UNLOCK_VOLUME                 = (($00000009 shl 16) or ($0000 shl 14) or (00007 shl 2) or 0);

type
    PPNP_VETO_TYPE      = ^PNP_VETO_TYPE;
    PNP_VETO_TYPE       = DWORD;

    PDEVINST            = ^DEVINST;
    DEVINST             = DWORD;

    PRETURN_TYPE        = ^RETURN_TYPE;
    RETURN_TYPE         = DWORD;

    PCONFIGRET          = ^CONFIGRET;
    CONFIGRET           = RETURN_TYPE;

    PHDEVINFO           = ^HDEVINFO;
    HDEVINFO            = Pointer;

    PDEVICE_TYPE        = ^DEVICE_TYPE;
    DEVICE_TYPE         = DWORD;

    PSTORAGE_BUS_TYPE   = ^STORAGE_BUS_TYPE;
    STORAGE_BUS_TYPE    = DWORD;

    PULONG_PTR          = ^ULONG_PTR;
    ULONG_PTR           = LONGWORD;

    PPTSTR              = ^LPWSTR;
    PTSTR               = LPWSTR;

    PSPDeviceInterfaceData = ^TSPDeviceInterfaceData;
    SP_DEVICE_INTERFACE_DATA = packed record
        cbSize              : DWORD;
        InterfaceClassGuid  : TGUID;
        Flags               : DWORD;
        Reserved            : ULONG_PTR;
    end;
    TSPDeviceInterfaceData = SP_DEVICE_INTERFACE_DATA;

    PSPDevInfoData = ^TSPDevInfoData;
    SP_DEVINFO_DATA = packed record
        cbSize    : DWORD;
        ClassGuid : TGUID;
        DevInst   : DWORD;
        Reserved  : ULONG_PTR;
    end;
    TSPDevInfoData = SP_DEVINFO_DATA;

    PSPDeviceInterfaceDetailDataA = ^TSPDeviceInterfaceDetailDataA;
    PSPDeviceInterfaceDetailDataW = ^TSPDeviceInterfaceDetailDataW;
    SP_DEVICE_INTERFACE_DETAIL_DATA_A = packed record
        cbSize      : DWORD;
        DevicePath  : array [0..0] of AnsiChar;
    end;
    SP_DEVICE_INTERFACE_DETAIL_DATA_W = packed record
        cbSize      : DWORD;
        DevicePath  : array [0..0] of WideChar;
    end;
    TSPDeviceInterfaceDetailDataA = SP_DEVICE_INTERFACE_DETAIL_DATA_A;
    TSPDeviceInterfaceDetailDataW = SP_DEVICE_INTERFACE_DETAIL_DATA_W;
    {$IFDEF UNICODE}
        TSPDeviceInterfaceDetailData = TSPDeviceInterfaceDetailDataW;
        PSPDeviceInterfaceDetailData = PSPDeviceInterfaceDetailDataW;
    {$ELSE}
        TSPDeviceInterfaceDetailData = TSPDeviceInterfaceDetailDataA;
        PSPDeviceInterfaceDetailData = PSPDeviceInterfaceDetailDataA;
    {$ENDIF UNICODE}
    
    PSTORAGE_DEVICE_NUMBER = ^TSTORAGE_DEVICE_NUMBER;
        STORAGE_DEVICE_NUMBER = record
            DeviceType      : DEVICE_TYPE;
            DeviceNumber    : DWORD;
            PartitionNumber : DWORD;
        end;
    TSTORAGE_DEVICE_NUMBER = STORAGE_DEVICE_NUMBER;

    DEV_BROADCAST_HDR = ^PDEV_BROADCAST_HDR;
        PDEV_BROADCAST_HDR  = packed record
            dbch_size         : DWORD;
            dbch_devicetype   : DWORD;
            dbch_reserved     : DWORD;
        end;

    DEV_BROADCAST_VOLUME = ^PDEV_BROADCAST_VOLUME;
        PDEV_BROADCAST_VOLUME = packed record
            dbcv_size           : DWORD;
            dbcv_devicetype     : DWORD;
            dbcv_reserved       : DWORD;
            dbcv_unitmask       : DWORD;
            dbcv_flags          : WORD;
        end;

    PSTORAGE_HOTPLUG_INFO = ^TSTORAGE_HOTPLUG_INFO;
        STORAGE_HOTPLUG_INFO = packed record
            Size                        : DWORD;
            MediaRemovable              : BOOLEAN;
            MediaHotplug                : BOOLEAN;
            DeviceHotplug               : BOOLEAN;
            WriteCacheEnableOverride    : BOOLEAN;
        end;
    TSTORAGE_HOTPLUG_INFO = STORAGE_HOTPLUG_INFO;

    PSTORAGE_PROPERTY_QUERY = ^TSTORAGE_PROPERTY_QUERY;
        STORAGE_PROPERTY_QUERY = packed record
            PropertyId          : DWORD;
            QueryType           : DWORD;
            AdditionalParameters: array[0..3] of Byte;
        end;
     TSTORAGE_PROPERTY_QUERY = STORAGE_PROPERTY_QUERY;

    PSTORAGE_DEVICE_DESCRIPTOR = ^TSTORAGE_DEVICE_DESCRIPTOR;
        STORAGE_DEVICE_DESCRIPTOR = packed record
            Version                 : ULONG;
            Size                    : ULONG;
            DeviceType              : Byte;
            DeviceTypeModifier      : Byte;
            RemovableMedia          : Boolean;
            CommandQueueing         : Boolean;
            VendorIdOffset          : ULONG;
            ProductIdOffset         : ULONG;
            ProductRevisionOffset   : ULONG;
            SerialNumberOffset      : ULONG;
            BusType                 : STORAGE_BUS_TYPE;
            RawPropertiesLength     : ULONG;
            RawDeviceProperties     : array [0..MAX_PATH] of Byte;
        end;
    TSTORAGE_DEVICE_DESCRIPTOR = STORAGE_DEVICE_DESCRIPTOR;

{    PSTORAGE_BUS_RESET_REQUEST = ^TSTORAGE_BUS_RESET_REQUEST;
        STORAGE_BUS_RESET_REQUEST = packed record
            PathId : Byte;
        end;
    TSTORAGE_BUS_RESET_REQUEST = STORAGE_BUS_RESET_REQUEST;

    STORAGE_MEDIA_TYPE = DWORD;
    PDEVICE_MEDIA_INFO = ^TDEVICE_MEDIA_INFO;
        DEVICE_MEDIA_INFO = packed record
            DeviceSpecific : packed record
            case BYTE of
                0 :(DiskInfo : packed record
                        Cylinders           : LARGE_INTEGER;
                        MediaType           : STORAGE_MEDIA_TYPE;
                        TracksPerCylinder   : DWORD;//ULONG
                        SectorsPerTrack     : DWORD;
                        BytesPerSector      : DWORD;
                        NumberMediaSides    : DWORD;
                        MediaCharacteristics: DWORD;
                    end );
                1 :(RemovableDiskInfo : packed record
                        Cylinders           : LARGE_INTEGER;
                        MediaType           : STORAGE_MEDIA_TYPE;
                        TracksPerCylinder   : DWORD;
                        SectorsPerTrack     : DWORD;
                        BytesPerSector      : DWORD;
                        NumberMediaSides    : DWORD;
                        MediaCharacteristics: DWORD;
                    end );
                2 :(TapeInfo : packed record
                        MediaType           : STORAGE_MEDIA_TYPE;
                        MediaCharacteristics: DWORD;
                        CurrentBlockSize    : DWORD;
                        BusType             : STORAGE_BUS_TYPE;
                        BusSpecificData : packed record
                        case INTEGER of
                        0 :(ScsiInformation : packed record
                                MediumType  : BYTE;//UCHAR
                                DensityCode : BYTE;
                            end );
                        end;
                    end );
            end;
    end;
    TDEVICE_MEDIA_INFO = DEVICE_MEDIA_INFO;

    PGET_MEDIA_TYPES = ^TGET_MEDIA_TYPES;
        GET_MEDIA_TYPES = packed record
            DeviceType      : DWORD;
            MediaInfoCount  : DWORD;
            MediaInfo       : array [0..0] of DEVICE_MEDIA_INFO;
        end;
    TGET_MEDIA_TYPES = GET_MEDIA_TYPES;}

    TDrive = packed record
        Volume          : String;
        VolumeName      : String;
        TailleLib       : String;
        TailleTot       : String;
        SystFich        : String;
        Properties      : String;
        DeviceType      : DWORD;
        BusType         : STORAGE_BUS_TYPE;
        MediaRemovable  : BOOLEAN;
        MediaHotplug    : BOOLEAN;
        DeviceHotplug   : BOOLEAN;
        Partition       : Integer;
    end;

    TPREVENT_MEDIA_REMOVAL = record
        PreventMediaRemoval : ByteBool;
    end;

    function SetupDiDestroyDeviceInfoList(DeviceInfoSet: HDEVINFO): BOOL; stdcall;external 'SetupApi.dll';
    function SetupDiEnumDeviceInterfaces(DeviceInfoSet:HDEVINFO;DeviceInfoData:PSPDevInfoData;
        const InterfaceClassGuid:TGUID;MemberIndex:DWORD;var DeviceInterfaceData:TSPDeviceInterfaceData):BOOL;stdcall;external 'SetupApi.dll';
    function CM_Get_Parent(var dnDevInstParent:DEVINST;dnDevInst:DEVINST;ulFlags:ULONG):CONFIGRET;stdcall;external 'CfgMgr32.dll';

    function CM_Query_And_Remove_SubTreeW(dnAncestor: DEVINST;pVetoType: PPNP_VETO_TYPE; pszVetoName: PWideChar;
        ulNameLength: ULONG; ulFlags: ULONG): CONFIGRET; stdcall;
    function CM_Query_And_Remove_SubTreeA(dnAncestor: DEVINST;pVetoType: PPNP_VETO_TYPE; pszVetoName: PAnsiChar;
        ulNameLength: ULONG; ulFlags: ULONG): CONFIGRET; stdcall;
    function CM_Query_And_Remove_SubTree(dnAncestor: DEVINST;pVetoType: PPNP_VETO_TYPE; pszVetoName: PTSTR;
        ulNameLength: ULONG; ulFlags: ULONG): CONFIGRET; stdcall;

    function CM_Request_Device_EjectW(dnDevInst:DEVINST;pVetoType:PPNP_VETO_TYPE;pszVetoName:PWideChar;
        ulNameLength:ULONG;ulFlags: ULONG):CONFIGRET; stdcall;
    function CM_Request_Device_EjectA(dnDevInst:DEVINST;pVetoType:PPNP_VETO_TYPE;pszVetoName:PAnsiChar;
        ulNameLength:ULONG;ulFlags: ULONG):CONFIGRET; stdcall;
    function CM_Request_Device_Eject(dnDevInst:DEVINST;pVetoType:PPNP_VETO_TYPE;pszVetoName:PTSTR;
        ulNameLength:ULONG;ulFlags: ULONG):CONFIGRET; stdcall;

    function SetupDiGetClassDevsW(ClassGuid:PGUID;const Enumerator:PWideChar;hwndParent:HWND;Flags:DWORD):HDEVINFO;stdcall;
    function SetupDiGetClassDevsA(ClassGuid:PGUID;const Enumerator:PAnsiChar;hwndParent:HWND;Flags:DWORD):HDEVINFO;stdcall;
    function SetupDiGetClassDevs(ClassGuid:PGUID;const Enumerator:PTSTR;hwndParent:HWND;Flags:DWORD):HDEVINFO;stdcall;

    function SetupDiGetDeviceInterfaceDetailW(DeviceInfoSet:HDEVINFO;DeviceInterfaceData:PSPDeviceInterfaceData;
        DeviceInterfaceDetailData:PSPDeviceInterfaceDetailData;DeviceInterfaceDetailDataSize:DWORD;
        var RequiredSize:DWORD;Device:PSPDevInfoData):BOOL;stdcall;
    function SetupDiGetDeviceInterfaceDetailA(DeviceInfoSet:HDEVINFO;DeviceInterfaceData:PSPDeviceInterfaceData;
        DeviceInterfaceDetailData:PSPDeviceInterfaceDetailData;DeviceInterfaceDetailDataSize:DWORD;
        var RequiredSize:DWORD;Device:PSPDevInfoData):BOOL;stdcall;
    function SetupDiGetDeviceInterfaceDetail(DeviceInfoSet:HDEVINFO;DeviceInterfaceData:PSPDeviceInterfaceData;
        DeviceInterfaceDetailData:PSPDeviceInterfaceDetailData;DeviceInterfaceDetailDataSize:DWORD;
        var RequiredSize:DWORD;Device:PSPDevInfoData):BOOL;stdcall;

{    function CM_Reenumerate_DevNode(dnDevInst: DEVINST;ulFlags: ULONG): CONFIGRET; stdcall;external 'CfgMgr32.dll';
    function GetVolumeNameForVolumeMountPointW(lpszVolumeMountPoint: LPCWSTR;
        lpszVolumeName: LPWSTR; cchBufferLength: DWORD): BOOL; stdcall;external 'kernel32.dll';
    function SetupDiGetInterfaceDeviceDetailW(DeviceInfoSet:HDEVINFO;DeviceInterfaceData:PSPDeviceInterfaceData;
        DeviceInterfaceDetailData:PSPDeviceInterfaceDetailDataW;DeviceInterfaceDetailDataSize:DWORD;RequiredSize:PDWORD;
        Device:PSPDevInfoData):BOOL;stdcall;external 'SetupApi.dll';}

    function DeviceNumberDrive(DeviceNumber:Integer;DriveType:UINT;szDosDeviceName:PCHAR):DEVINST;
    function Eject_USB(LetVol:Char;Rep,TempRep:Integer;MessageEject,MultiSupport:Boolean):Boolean;stdcall;
    function Eject_DevHotPlugMedia(LetVol:Char;Rep,TempRep:Integer;MessageEject,MediaRemove:Boolean):Boolean;
    function Eject_DevHotPlug(LetVol:Char;Rep,TempRep:Integer;MessageEject,RemoveMediaHotPlug:Boolean):Boolean;

    Procedure Liste_USB(Lecteurs:TStrings;DriveRemovable,DriveFixed,DriveCDRom:Boolean);stdcall;

implementation

const
    {$IFDEF UNICODE}
        LettreFin = 'W';
    {$ELSE}
        LettreFin = 'A';
    {$ENDIF UNICODE}

Var
    Drive : TDrive;

//Partie ejection peripherique

function DeviceNumberDrive(DeviceNumber:Integer;DriveType:UINT;szDosDeviceName:PCHAR):DEVINST;
var
    IsFloppy                            : Boolean;
    BoucWh                              : Boolean;
    ValGUID                             : TGUID;
    ValHDevInfo                         : HDEVINFO;
    hDrive                              : THandle;
    dwIndex, dwSize, dwBytesReturned    : DWORD;
    FunctionResult                      : Boolean;
    SPDeviceInterfaceDetailData         : PSPDeviceInterfaceDetailData;
    SPDeviceInterfaceData               : SP_DEVICE_INTERFACE_DATA;
    SPDevInfoData                       : SP_DEVINFO_DATA;
    StorageDeviceNumber                 : STORAGE_DEVICE_NUMBER;
begin
    Result:=0;
    IsFloppy:=true;
    if StrPos(szDosDeviceName, '\Floppy') = nil then
        IsFloppy:=false;
    case (DriveType)  of
        DRIVE_REMOVABLE :   if ( IsFloppy ) then
                            begin
                                ValGUID := GUID_DEVINTERFACE_FLOPPY;
                            end
                            else
                            begin
                                ValGUID := GUID_DEVINTERFACE_DISK;
                            end;
        DRIVE_FIXED :       ValGUID := GUID_DEVINTERFACE_DISK;
        DRIVE_CDROM :       ValGUID := GUID_DEVINTERFACE_CDROM;
    else
        exit;
    end;

    ValHDevInfo := SetupDiGetClassDevs(@ValGUID,nil,0,DIGCF_PRESENT or DIGCF_DEVICEINTERFACE);
    if (Cardinal(ValHDevInfo)=INVALID_HANDLE_VALUE) then
        exit;

    dwIndex := 0;
    ZeroMemory(@SPDevInfoData,SizeOf(SPDevInfoData));
    SPDeviceInterfaceData.cbSize:=SizeOf(SPDeviceInterfaceData);

    BoucWh:=True;
    while (BoucWh=true) do
    begin
        FunctionResult:=SetupDiEnumDeviceInterfaces(ValHDevInfo,nil,ValGUID,dwIndex,SPDeviceInterfaceData);
        if FunctionResult=False then
            break;
        dwSize:=0;
        SetupDiGetDeviceInterfaceDetail(ValHDevInfo,@SPDeviceInterfaceData,nil,0,dwSize,nil);
        if (dwSize<>0)and(dwSize<=1024)then
        begin
            GetMem(SPDeviceInterfaceDetailData,dwSize);
            try
                SPDeviceInterfaceDetailData.cbSize:=SizeOf(SPDeviceInterfaceDetailData^);
                ZeroMemory(@SPDevInfoData,SizeOf(SPDevInfoData));
                SPDevInfoData.cbSize:=SizeOf(SPDevInfoData);
                FunctionResult:=SetupDiGetDeviceInterfaceDetail(ValHDevInfo,@SPDeviceInterfaceData,SPDeviceInterfaceDetailData,dwSize,dwSize,@SPDevInfoData);
                if FunctionResult then
                begin
                    hDrive:=DWORD(-1);
                    try
                        hDrive := CreateFile(SPDeviceInterfaceDetailData.DevicePath,0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
                        if (hDrive<>INVALID_HANDLE_VALUE) then
                        begin
                            dwBytesReturned := 0;
                            FunctionResult := DeviceIoControl(hDrive,IOCTL_STORAGE_GET_DEVICE_NUMBER,nil,0,@StorageDeviceNumber,SizeOf(StorageDeviceNumber),dwBytesReturned, nil);
                            if FunctionResult  then
                            begin
                                if DeviceNumber = LongInt(StorageDeviceNumber.DeviceNumber) then
                                begin
                                    Result:= SPDevInfoData.DevInst;
                                    break;
                                end;
                            end;
                        end;
                    finally
                        CloseHandle(hDrive);
                    end;
                end;
            finally
                FreeMem(SPDeviceInterfaceDetailData);
            end;
        end;
        dwIndex:=dwIndex+1;
    end;
    SetupDiDestroyDeviceInfoList(ValHDevInfo);
end;

function Eject_DevHotPlug(LetVol:Char;Rep,TempRep:Integer;MessageEject,RemoveMediaHotPlug:Boolean):Boolean;
var
    DeviceNumber        : LongInt;
    dwBytesReturned     : DWord;
    DriveType           : UINT;
    hVolume             : THandle;
    StorageDeviceNumber : STORAGE_DEVICE_NUMBER;
    I                   : Integer;
    ResultInt           : DWORD;
    ResultIntNod        : DWORD;
    ResultBool          : Boolean;
    DeviceInst          : DEVINST;
    DevInstParent       : DEVINST;
    szDosDeviceName     : array[0..MAX_PATH] of Char;
    VetoType            : PNP_VETO_TYPE;
    VetoNameW           : array[0..MAX_PATH] of WChar;
begin
    Result:=False;
    DeviceNumber:=-1;
    hVolume:=INVALID_HANDLE_VALUE;
    try
        hVolume:=CreateFile(PChar('\\.\'+LetVol+':'),0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
        if hVolume=INVALID_HANDLE_VALUE then
            exit;
        dwBytesReturned:=0;
        ResultBool:=DeviceIoControl(hVolume,IOCTL_STORAGE_GET_DEVICE_NUMBER,nil,0,@StorageDeviceNumber,SizeOf(StorageDeviceNumber),dwBytesReturned,nil);
        if ResultBool = True  then
            DeviceNumber:=StorageDeviceNumber.DeviceNumber;
    finally
        CloseHandle(hVolume);
    end;
    if DeviceNumber=-1 then
        exit;


    DriveType:=GetDriveType(PChar(String(LetVol+':')));
    szDosDeviceName[0]:=#0;
    ResultInt:=QueryDosDevice(PChar(String(LetVol+':')),szDosDeviceName,MAX_PATH);
    if ResultInt=0 then
        exit;

    DeviceInst:=DeviceNumberDrive(DeviceNumber,DriveType,szDosDeviceName);
    if DeviceInst = 0 then
        exit;

    VetoType := PNP_VetoTypeUnknown;
    VetoNameW[0] := #0;
    DevInstParent := 0;
//    http://msdn.microsoft.com/en-us/library/ms791198.aspx
    CM_Get_Parent(DevInstParent, DeviceInst, 0);

    if not RemoveMediaHotPlug then
    begin
        for I := 0 to Rep - 1 do
        begin
            VetoNameW[0] := #0;
//            http://msdn.microsoft.com/en-us/library/ms790831.aspx
            if MessageEject then
                ResultInt:=CM_Request_Device_Eject(DevInstParent,nil,nil,0,0)
            else
                ResultInt:=CM_Request_Device_Eject(DevInstParent,@VetoType,VetoNameW,MAX_PATH,0);
            if (ResultInt=CR_SUCCESS)and(VetoType=PNP_VetoTypeUnknown) then
            begin
                Result:=True;
                Break;
            end;
            Sleep(TempRep);
        end;
    end
    else
    begin  // if CM_Request_Device_Eject(DevInstParent,@VetoType,VetoNameW,MAX_PATH,0)=CR_REMOVE_VETOED then CM_Query_And_Remove_SubTree(DeviceInst,nil,nil,0,0);
        for I := 0 to Rep - 1 do
        begin
            VetoNameW[0] := #0;
//            http://msdn.microsoft.com/en-us/library/ms790877.aspx
            if MessageEject then
                ResultIntNod:=CM_Query_And_Remove_SubTree(DeviceInst,nil,nil,0,0)
            else
                ResultIntNod:=CM_Query_And_Remove_SubTree(DeviceInst,@VetoType,VetoNameW,MAX_PATH,0);
            if (ResultIntNod=CR_SUCCESS)and(VetoType=PNP_VetoTypeUnknown) then
            begin
                Result:=True;
                if MessageEject then
                    MessageDlg('Le matériel peut-être retiré en toute sécurité !',mtInformation,[mbOK],0);
                Break;
            end;
            Sleep(TempRep);
        end;
    end;
end;

function Eject_DevHotPlugMedia(LetVol:Char;Rep,TempRep:Integer;MessageEject,MediaRemove: Boolean):Boolean;
var
    HVolume             : THandle;
    lpBytesReturned     : DWORD;
    PreventRemoval      : TPREVENT_MEDIA_REMOVAL;
    FormatLettreLecteur : String;
    I                   : Integer;
begin
    Result:=False;
    hVolume:=INVALID_HANDLE_VALUE;
    try
        hVolume:=CreateFile(PChar('\\.\'+LetVol+':'),FILE_SHARE_READ or FILE_SHARE_WRITE,0,nil,OPEN_EXISTING,0,0);
        if hVolume=INVALID_HANDLE_VALUE then
            hVolume:=CreateFile(PChar('\\.\'+LetVol+':'),GENERIC_READ,0,nil,OPEN_EXISTING,0,0);
        if hVolume=INVALID_HANDLE_VALUE then
            hVolume:=CreateFile(PChar('\\.\'+LetVol+':'),0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
        if hVolume=INVALID_HANDLE_VALUE then
            exit;
        for I := 0 to Rep - 1 do
        begin
            PreventRemoval.PreventMediaRemoval:=False;
            if DeviceIoControl(hVolume,FSCTL_LOCK_VOLUME, nil,0,nil,0,lpBytesReturned,nil) then //Vérrouillage volume
                if DeviceIoControl(hVolume,FSCTL_DISMOUNT_VOLUME, nil,0,nil,0,lpBytesReturned,nil) then //Démontage du volume
                    if DeviceIoControl(hVolume,IOCTL_STORAGE_MEDIA_REMOVAL,@PreventRemoval,SizeOf(TPREVENT_MEDIA_REMOVAL),nil,0,lpBytesReturned,nil) then //Control du volume
                        if DeviceIoControl(hVolume,IOCTL_STORAGE_EJECT_MEDIA,nil,0,nil,0,lpBytesReturned,nil)then //Ejection du volume
                            if DeviceIoControl(hVolume,FSCTL_UNLOCK_VOLUME,nil,0,nil,0,lpBytesReturned,nil) then //Déverrouillage du volume
                            begin
                                FormatLettreLecteur:=Format('%s:\',[Uppercase(LetVol)]);
//                                Avertir le système que l'USB est demonter
                                ShChangeNotify(SHCNE_MEDIAREMOVED,SHCNF_PATH,PChar(FormatLettreLecteur),Nil);
                                Result:=True;
                                if (MessageEject) and (not MediaRemove) then
                                    MessageDlg('Le matériel peut-être retiré en toute sécurité !',mtInformation,[mbOK],0);
                                if (MessageEject) and (MediaRemove) then
                                    MessageDlg('Le lecteur est ouvert !',mtInformation,[mbOK],0);
                                Break;
                            end;
            if not Result then
                Sleep(TempRep);
        end;
    finally
        CloseHandle(hVolume);
    end;

    if (not Result) and (MessageEject) and (MediaRemove) then
        MessageDlg('Le lecteur est en cours d''utilisation par un autre processus !',mtWarning,[mbOK],0);
    if (not Result) and (not MediaRemove) then
        Eject_DevHotPlug(LetVol,Rep,TempRep,MessageEject,False);
end;

function Eject_USB(LetVol:Char;Rep,TempRep:Integer;MessageEject,MultiSupport:Boolean):Boolean;
var
    hVolume             : THandle;
    GetMediaTypes       : STORAGE_HOTPLUG_INFO;
    lpBytesReturned     : DWORD;
begin
    Result:=False;
    hVolume:=INVALID_HANDLE_VALUE;
    try
        hVolume:=CreateFile(PChar('\\.\'+LetVol+':'),0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
        if hVolume=INVALID_HANDLE_VALUE then
            exit;
        DeviceIoControl(hVolume,IOCTL_STORAGE_GET_HOTPLUG_INFO,nil,0,@GetMediaTypes,sizeof(GetMediaTypes),lpBytesReturned,nil);
    finally
        CloseHandle(hVolume);
    end;
    if (GetMediaTypes.DeviceHotplug) and (GetMediaTypes.MediaRemovable) and (MultiSupport=False) then //support usb standard...
    begin
        if Eject_DevHotPlugMedia(LetVol,Rep,TempRep,MessageEject,False) then
            Result:=True;
    end
    else
        if GetMediaTypes.DeviceHotplug then //support disque usb...
        begin
            if Eject_DevHotPlug(LetVol,Rep,TempRep,MessageEject,False)then
                Result:=True;
        end
        else
            if (GetMediaTypes.MediaRemovable) and (GetMediaTypes.MediaHotplug) then //support lecteur carte interne...
            begin
                if Eject_DevHotPlug(LetVol,Rep,TempRep,MessageEject,True)then
                    Result:=True;
            end
            else
                if GetMediaTypes.MediaRemovable then //support cd/dvd...
                begin
                    if Eject_DevHotPlugMedia(LetVol,Rep,TempRep,MessageEject,True) then
                        Result:=True;
                end
                else
                    MessageDlg('Il est impossible d''éjecter un périphérique interne !',mtWarning,[mbOK],0); //Disque dur
end;


{function GetVolumeNameForVolumeMountPointString(LetVol: Char): string;
var
    Volume: array [0..MAX_PATH] of Char;
begin
    if GetDriveType(PChar(Format('%s:\',[Uppercase(LetVol)])))=DRIVE_REMOVABLE then
    begin
        FillChar(Volume[0],SizeOf(Volume),0);
        GetVolumeNameForVolumeMountPointW(PChar(Format('%s:\',[Uppercase(LetVol)])),@Volume[0],SizeOf(Volume));
        Result:=Volume;
    end;
end;}

//Partie informations peripherique

Procedure StorageDeviceNumberString(Disque:String);
var
    HFile               : THandle;
    lpBytesReturned       : DWORD;
    StorageDeviceNumber : STORAGE_DEVICE_NUMBER;
begin
    Drive.DeviceType:=0;
    Drive.Partition:=0;
    HFile:=INVALID_HANDLE_VALUE;
    try
        HFile:=CreateFile(PChar('\\.\'+Disque),0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
        if HFile<>INVALID_HANDLE_VALUE then
        begin
            DeviceIoControl(HFile,IOCTL_STORAGE_GET_DEVICE_NUMBER,nil,0,@StorageDeviceNumber,SizeOf(StorageDeviceNumber),lpBytesReturned, nil);
            Drive.DeviceType:=StorageDeviceNumber.DeviceType;
            Drive.Partition:=StorageDeviceNumber.PartitionNumber;
        end;
    finally
        CloseHandle(HFile);
    end;
end;

{Procedure StorageMediaTypeString(Disque:String);
var
    HFile               : THandle;
    lpBytesReturned     : DWORD;
    StorageMediaType    : GET_MEDIA_TYPES;
    MediaTypes          : PGET_MEDIA_TYPES;
    Buffer              : Array[0..2047] of Byte;
    Result              : String;
begin
    Result:='';
    HFile:=INVALID_HANDLE_VALUE;
    try
        HFile:=CreateFile(PChar('\\.\'+Disque),0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
        if HFile<>INVALID_HANDLE_VALUE then
        begin
            DeviceIoControl(HFile,IOCTL_STORAGE_GET_MEDIA_TYPES_EX,nil,0,@StorageMediaType,SizeOf(StorageMediaType),lpBytesReturned, nil);
            if DeviceIoControl(HFile,IOCTL_STORAGE_GET_MEDIA_TYPES_EX,nil,0,@Buffer,SizeOf(Buffer),lpBytesReturned,nil) then
                MediaTypes := PGET_MEDIA_TYPES(@Buffer);
            Result:=IntTostr(MediaTypes.MediaInfo[0].DeviceSpecific.RemovableDiskInfo.MediaType);
        end;
    finally
        CloseHandle(HFile);
    end;
end;}

Procedure DeviceDescriptorString(Disque:String);
{type
  PCharArray = ^TCharArray;
  TCharArray = Array[0..MAX_PATH] of Char;}
var
    HFile                       : THandle;
    PropQuery                   : STORAGE_PROPERTY_QUERY;
    DeviceDescriptor            : STORAGE_DEVICE_DESCRIPTOR;
    lpBytesReturned             : DWORD;
    I                           : Integer;
    Value                       : Char;
    PosValue                    : Integer;
//    TestString                  : String;
//    TestChar                    : PChar;
begin
    Drive.Properties:='';
    HFile:=INVALID_HANDLE_VALUE;
    try
        HFile:=CreateFile(PChar('\\.\'+Disque),0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
        if HFile<>INVALID_HANDLE_VALUE then
        begin
            ZeroMemory(@PropQuery, SizeOf(PropQuery));
            ZeroMemory(@DeviceDescriptor, SizeOf(DeviceDescriptor));
            DeviceDescriptor.Size := SizeOf(DeviceDescriptor);
            DeviceIoControl(HFile,IOCTL_STORAGE_QUERY_PROPERTY,@PropQuery,SizeOf(PropQuery),@DeviceDescriptor,DeviceDescriptor.Size,lpBytesReturned,nil);
{//            vendorid
            if DeviceDescriptor.VendorIdOffset<>0 then
            begin
                TestChar:=@PCharArray(@DeviceDescriptor)^[DeviceDescriptor.VendorIdOffset];
                TestString:=Trim(TestChar);
                TestString:= String(PChar(@DeviceDescriptor) + DeviceDescriptor.VendorIdOffset);
            end;
//            productid
            if DeviceDescriptor.ProductIdOffset<>0 then
            begin
                TestChar:=@PCharArray(@DeviceDescriptor)^[DeviceDescriptor.ProductIdOffset];
                TestString:=Trim(TestChar);
                TestString:= String(PChar(@DeviceDescriptor) + DeviceDescriptor.ProductIdOffset);
            end;
//            product révision
            if DeviceDescriptor.ProductRevisionOffset<>0 then
            begin
                TestChar:=@PCharArray(@DeviceDescriptor)^[DeviceDescriptor.ProductRevisionOffset];
                TestString:=Trim(TestChar);
                TestString:= String(PChar(@DeviceDescriptor) + DeviceDescriptor.ProductRevisionOffset);
            end;}
            Drive.Properties:='';
            PosValue:=0;
            for I := DeviceDescriptor.RawPropertiesLength-1 Downto 0 do
                if DeviceDescriptor.RawDeviceProperties[i]=0 then
                begin
                    PosValue:=I;
                    Break;
                end;
            Value:=#0;
            for I:=PosValue to DeviceDescriptor.RawPropertiesLength-1 do
            begin
                case DeviceDescriptor.RawDeviceProperties[i] of
                    32..126:    begin
                                    if Drive.Properties<>'' then
                                        Value:=Drive.Properties[Length(Drive.Properties)-1];
                                    if (Value<>' ')or(DeviceDescriptor.RawDeviceProperties[i]<>32)then
                                        Drive.Properties:=Drive.Properties+Chr(DeviceDescriptor.RawDeviceProperties[i]);
                                end;
                end;
            end;
        end;
    finally
        CloseHandle(HFile);
    end;
end;

function FormatTaille(Value: Extended): String;
var
    i   : Integer;
begin
    i:=0;
    while (Value>=1000) or (i=4) do
    begin
        Value:=Value / 1024;
        Inc(i);
    end;
    case i of
        0 : Result:=FloatToStrF(Value,ffFixed,18,2)+' octet(s)';
        1 : Result:=FloatToStrF(Value,ffFixed,18,2)+' Ko';
        2 : Result:=FloatToStrF(Value,ffFixed,18,2)+' Mo';
        3 : Result:=FloatToStrF(Value,ffFixed,18,2)+' Go';
        4 : Result:=FloatToStrF(Value,ffFixed,18,2)+' To';
    end;
end;

Procedure InfoDevice(Disque:String);
var
    Volume                  : THandle;
    Returned                : DWORD;
    VolName                 : Array[0..MAX_PATH]Of Char;
    FileSysName             : Array[0..MAX_PATH]Of Char;
    VolSerial               : DWord;
    FileMaxLen              : DWord;
    FileFlags               : DWord;
    FreeAvailable           : Int64;
    TotalSpace              : Int64;
    FreeAvailableString     : String;
    TotalSpaceString        : String;
    TempVolName             : String;
begin
    Drive.VolumeName:='';
    Drive.TailleLib:='0 Go';
    Drive.TailleTot:='0 Go';
    Drive.SystFich:='';
    if GetVolumeInformation(PChar(Disque+'\'),VolName,Max_Path,@VolSerial,FileMaxLen,FileFlags,FileSysName,MAX_PATH) then
    begin
        GetDiskFreeSpaceEx(PChar(Disque),FreeAvailable,TotalSpace,nil);
        FreeAvailableString:=FormatTaille(FreeAvailable);
        TotalSpaceString:=FormatTaille(TotalSpace);
        if VolName<>'' then
            TempVolName:=VolName
        else
            TempVolName:='';
        Drive.VolumeName:=TempVolName;
        Drive.SystFich:=FileSysName;
        Drive.TailleLib:=FreeAvailableString;
        Drive.TailleTot:=TotalSpaceString;
    end
    else
    begin
        TempVolName:='Lecteur Vide';
        Volume := CreateFile(PChar('\\.\' + Disque + ':'),0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil, OPEN_EXISTING, 0, 0);
        try
            if not DeviceIoControl(Volume, IOCTL_STORAGE_CHECK_VERIFY, nil, 0, nil, 0, Returned, nil) then
            begin
                Drive.VolumeName:=TempVolName;
                Drive.SystFich:='';
                Drive.TailleLib:='0 Go';
                Drive.TailleTot:='0 Go';
            end;
        finally
            CloseHandle(Volume);
        end;
    end;
end;

function HotPlugInfo(Disque:String):Boolean;
var
    HFile                       : THandle;
    GetMediaTypes               : STORAGE_HOTPLUG_INFO;
    PropQuery                   : STORAGE_PROPERTY_QUERY;
    DeviceDescriptor            : STORAGE_DEVICE_DESCRIPTOR;
    lpBytesReturned             : DWORD;
begin
    Result:=False;
    HFile:=INVALID_HANDLE_VALUE;
    try
        HFile:=CreateFile(PChar('\\.\'+Disque),0,FILE_SHARE_READ or FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
        if HFile<>INVALID_HANDLE_VALUE then
        begin
            DeviceIoControl(HFile,IOCTL_STORAGE_GET_HOTPLUG_INFO,nil,0,@GetMediaTypes,sizeof(GetMediaTypes),lpBytesReturned,nil);
            ZeroMemory(@PropQuery, SizeOf(PropQuery));
            ZeroMemory(@DeviceDescriptor, SizeOf(DeviceDescriptor));
            DeviceDescriptor.Size := SizeOf(DeviceDescriptor);
            DeviceIoControl(HFile,IOCTL_STORAGE_QUERY_PROPERTY,@PropQuery,SizeOf(PropQuery),@DeviceDescriptor,DeviceDescriptor.Size,lpBytesReturned,nil);
            if (DeviceDescriptor.BusType=BusTypeUsb)or(DeviceDescriptor.BusType=BusType1394)or(DeviceDescriptor.BusType=BusTypeAtapi)or
                ((GetMediaTypes.MediaRemovable)and(GetMediaTypes.MediaHotplug))or
                (GetMediaTypes.DeviceHotplug)or(GetMediaTypes.MediaRemovable) then
                Result:=True
            else
                Result:=False;
            Drive.Volume:=Disque+'\';
            Drive.MediaRemovable:=GetMediaTypes.MediaRemovable;
            Drive.MediaHotplug:=GetMediaTypes.MediaHotplug;
            Drive.DeviceHotplug:=GetMediaTypes.DeviceHotplug;
            Drive.BusType:=DeviceDescriptor.BusType;
            DeviceDescriptorString(Disque);
            InfoDevice(Disque);
            StorageDeviceNumberString(Disque);
        end;
    finally
        CloseHandle(HFile);
    end;
end;

Procedure Liste_USB(Lecteurs:TStrings;DriveRemovable,DriveFixed,DriveCDRom:Boolean);
var
    Num     : Integer;
    Bits    : set of 0..25;
    Disque  : String;
begin
    Integer(Bits):=GetLogicalDrives;
    for Num := 0 to 25 do
    begin
        if Num in Bits then
        begin
            Disque:=Char(Num+Ord('A'))+':';
            case GetDriveType(PChar(Disque)) of
                DRIVE_REMOVABLE :   if DriveRemovable then
                                        if HotPlugInfo(Disque) then
                                            Lecteurs.Append(Drive.Volume+' '+Drive.Properties+' Removable device'+' '+Drive.SystFich+' ( '+Drive.TailleLib+' / '+Drive.TailleTot+' ) '+Drive.VolumeName);
                DRIVE_FIXED     :   if DriveFixed then
                                        if HotPlugInfo(Disque) then
                                            Lecteurs.Append(Drive.Volume+' '+Drive.Properties+' Disk Removable External'+' '+Drive.SystFich+' ( '+Drive.TailleLib+' / '+Drive.TailleTot+' ) '+Drive.VolumeName)
                                        else
                                            Lecteurs.Append(Drive.Volume+' '+Drive.Properties+' Hard Disk'+' '+Drive.SystFich+' ( '+Drive.TailleLib+' / '+Drive.TailleTot+' ) '+Drive.VolumeName);
                DRIVE_CDROM     :   if DriveCDRom then
                                        if HotPlugInfo(Disque) then
                                            Lecteurs.Append(Drive.Volume+' '+Drive.Properties+' Device CD-ROM / DVD-ROM'+' '+Drive.SystFich+' ( '+Drive.TailleLib+' / '+Drive.TailleTot+' ) '+Drive.VolumeName);
            end;
        end;
    end;
end;

function CM_Query_And_Remove_SubTreeW; external 'SetupApi.dll' name 'CM_Query_And_Remove_SubTreeW';
function CM_Query_And_Remove_SubTreeA; external 'SetupApi.dll' name 'CM_Query_And_Remove_SubTreeA';
function CM_Query_And_Remove_SubTree; external 'SetupApi.dll' name 'CM_Query_And_Remove_SubTree' + LettreFin;

function CM_Request_Device_EjectW; external 'SetupApi.dll' name 'CM_Request_Device_EjectW';
function CM_Request_Device_EjectA; external 'SetupApi.dll' name 'CM_Request_Device_EjectA';
function CM_Request_Device_Eject; external 'SetupApi.dll' name 'CM_Request_Device_Eject' + LettreFin;

function SetupDiGetClassDevsW; external 'SetupApi.dll' name 'SetupDiGetClassDevsW';
function SetupDiGetClassDevsA; external 'SetupApi.dll' name 'SetupDiGetClassDevsA';
function SetupDiGetClassDevs; external 'SetupApi.dll' name 'SetupDiGetClassDevs' + LettreFin;

function SetupDiGetDeviceInterfaceDetailW; external 'SetupApi.dll' name 'SetupDiGetDeviceInterfaceDetailW';
function SetupDiGetDeviceInterfaceDetailA; external 'SetupApi.dll' name 'SetupDiGetDeviceInterfaceDetailA';
function SetupDiGetDeviceInterfaceDetail; external 'SetupApi.dll' name 'SetupDiGetDeviceInterfaceDetail' + LettreFin;

end.
