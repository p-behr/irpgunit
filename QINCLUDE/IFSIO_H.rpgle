     D/if defined(IFSIO_H)
     D/eof
     D/endif

     D/define IFSIO_H
      **********************************************************************
      *  IFS File IO Prototypes.
      **********************************************************************
      *  Copyright (c) 2013-2019 iRPGUnit Project Team
      *  All rights reserved. This program and the accompanying materials
      *  are made available under the terms of the Common Public License v1.0
      *  which accompanies this distribution, and is available at
      *  http://www.eclipse.org/legal/cpl-v10.html
      **********************************************************************

      **********************************************************************
      * Some CCSID definitions that I've found useful
      **********************************************************************
     D CP_MSDOS        C                   437
     D CP_ISO8859_1    C                   819
     D CP_WINDOWS      C                   1252
     D CP_UTF8         C                   1208
     D CP_UCS2         C                   1200
     D CP_CURJOB       C                   0

      **********************************************************************
      *  Flags for use in open()
      *
      * More than one can be used -- add them together.
      **********************************************************************
      *  00000000000000000000000000000001          Reading Only
     D O_RDONLY        C                   1
      *  00000000000000000000000000000010          Writing Only
     D O_WRONLY        C                   2
      *  00000000000000000000000000000100          Reading & Writing
     D O_RDWR          C                   4
      *  00000000000000000000000000001000          Create File if needed
     D O_CREAT         C                   8
      *  00000000000000000000000000010000          Exclusively create --
      *                                              open will fail if it
      *                                              already exists.
     D O_EXCL          C                   16
      *  00000000000000000000000000100000          Assign a CCSID to new
      *                                            file.
     D O_CCSID         C                   32
      *  00000000000000000000000001000000          Truncate file to 0 bytes
     D O_TRUNC         C                   64
      *  00000000000000000000000100000000          Append to file
      *                                            (write data at end only)
     D O_APPEND        C                   256
      *  00000000000000000000010000000000          Synchronous write
     D O_SYNC          C                   1024
      *  00000000000000000000100000000000          Sync write, data only
     D O_DSYNC         C                   2048
      *  00000000000000000001000000000000          Sync read
     D O_RSYNC         C                   4096
      *  00000000000000001000000000000000          No controlling terminal
     D O_NOCTTY        C                   32768
      *  00000000000000010000000000000000          Share with readers only
     D O_SHARE_RDONLY  C                   65536
      *  00000000000000100000000000000000          Share with writers only
     D O_SHARE_WRONLY  C                   131072
      *  00000000000001000000000000000000          Share with read & write
     D O_SHARE_RDWR    C                   262144
      *  00000000000010000000000000000000          Share with nobody.
     D O_SHARE_NONE    C                   524288
      *  00000000100000000000000000000000          Assign a code page
     D O_CODEPAGE      C                   8388608
      *  00000001000000000000000000000000          Open in text-mode
     D O_TEXTDATA      C                   16777216
      /if defined(*V5R2M0)
      *  00000010000000000000000000000000          Allow text translation
      *                                            on newly created file.
      * Note: O_TEXT_CREAT requires all of the following flags to work:
      *           O_CREAT+O_TEXTDATA+(O_CODEPAGE or O_CCSID)
     D O_TEXT_CREAT    C                   33554432
      /endif
      *  00001000000000000000000000000000          Inherit mode from dir
     D O_INHERITMODE   C                   134217728
      *  00100000000000000000000000000000          Large file access
      *                                            (for >2GB files)
     D O_LARGEFILE     C                   536870912

      **********************************************************************
      * Access mode flags for access() and accessx()
      *
      *   F_OK = File Exists
      *   R_OK = Read Access
      *   W_OK = Write Access
      *   X_OK = Execute or Search
      **********************************************************************
     D F_OK            C                   0
     D R_OK            C                   4
     D W_OK            C                   2
     D X_OK            C                   1

      **********************************************************************
      * class of users flags for accessx()
      *
      *   ACC_SELF = Check access based on effective uid/gid
      *   ACC_INVOKER = Check access based on real uid/gid
      *                 ( this is equvalent to calling access() )
      *   ACC_OTHERS = Check access of someone not the owner
      *   ACC_ALL = Check access of all users
      **********************************************************************
     D ACC_SELF        C                   0
     D ACC_INVOKER     C                   1
     D ACC_OTHERS      C                   8
     D ACC_ALL         C                   32

      **********************************************************************
      *      Mode Flags.
      *         basically, the mode parm of open(), creat(), chmod(),etc
      *         uses 9 least significant bits to determine the
      *         file's mode. (peoples access rights to the file)
      *
      *           user:       owner    group    other
      *           access:     R W X    R W X    R W X
      *           bit:        8 7 6    5 4 3    2 1 0
      *
      * (This is accomplished by adding the flags below to get the mode)
      **********************************************************************
      *                                         owner authority
     D S_IRUSR         C                   256
     D S_IWUSR         C                   128
     D S_IXUSR         C                   64
     D S_IRWXU         C                   448
      *                                         group authority
     D S_IRGRP         C                   32
     D S_IWGRP         C                   16
     D S_IXGRP         C                   8
     D S_IRWXG         C                   56
      *                                         other people
     D S_IROTH         C                   4
     D S_IWOTH         C                   2
     D S_IXOTH         C                   1
     D S_IRWXO         C                   7
      *                                         special modes:
      *                                         Set effective GID
     D S_ISGID         C                   1024
      *                                         Set effective UID
     D S_ISUID         C                   2048

      **********************************************************************
      * My own special MODE shortcuts for open() (instead of those above)
      **********************************************************************
     D M_RDONLY        C                   const(292)
     D M_RDWR          C                   const(438)
     D M_RWX           C                   const(511)

      **********************************************************************
      * "whence" constants for use with seek(), lseek() and others
      **********************************************************************
     D SEEK_SET        C                   CONST(0)
     D SEEK_CUR        C                   CONST(1)
     D SEEK_END        C                   CONST(2)

      **********************************************************************
      * flags specified in the f_flags element of the ds_statvfs
      *   data structure used by the statvfs() API
      **********************************************************************
     D ST_RDONLY...
     D                 C                   CONST(1)
     D ST_NOSUID...
     D                 C                   CONST(2)
     D ST_CASE_SENSITITIVE...
     D                 C                   CONST(4)
     D ST_CHOWN_RESTRICTED...
     D                 C                   CONST(8)
     D ST_THREAD_SAFE...
     D                 C                   CONST(16)
     D ST_DYNAMIC_MOUNT...
     D                 C                   CONST(32)
     D ST_NO_MOUNT_OVER...
     D                 C                   CONST(64)
     D ST_NO_EXPORTS...
     D                 C                   CONST(128)
     D ST_SYNCHRONOUS...
     D                 C                   CONST(256)

      **********************************************************************
      * Constants used by pathconf() API
      **********************************************************************
     D PC_CHOWN_RESTRICTED...
     D                 C                   0
     D PC_LINK_MAX...
     D                 C                   1
     D PC_MAX_CANON...
     D                 C                   2
     D PC_MAX_INPUT...
     D                 C                   3
     D PC_NAME_MAX...
     D                 C                   4
     D PC_NO_TRUNC...
     D                 C                   5
     D PC_PATH_MAX...
     D                 C                   6
     D PC_PIPE_BUF...
     D                 C                   7
     D PC_VDISABLE...
     D                 C                   8
     D PC_THREAD_SAFE...
     D                 C                   9

      **********************************************************************
      * Constants used by sysconf() API
      **********************************************************************
     D SC_CLK_TCK...
     D                 C                   2
     D SC_NGROUPS_MAX...
     D                 C                   3
     D SC_OPEN_MAX...
     D                 C                   4
     D SC_STREAM_MAX...
     D                 C                   5
     D SC_CCSID...
     D                 C                   10
     D SC_PAGE_SIZE...
     D                 C                   11
     D SC_PAGESIZE...
     D                 C                   12

      **********************************************************************
      * File Information Structure (stat)
      *   struct stat {
      *     mode_t         st_mode;       /* File mode                       */
      *     ino_t          st_ino;        /* File serial number              */
      *     nlink_t        st_nlink;      /* Number of links                 */
      *     unsigned short st_reserved2;  /* Reserved                    @B4A*/
      *     uid_t          st_uid;        /* User ID of the owner of file    */
      *     gid_t          st_gid;        /* Group ID of the group of file   */
      *     off_t          st_size;       /* For regular files, the file
      *                                      size in bytes                   */
      *     time_t         st_atime;      /* Time of last access             */
      *     time_t         st_mtime;      /* Time of last data modification  */
      *     time_t         st_ctime;      /* Time of last file status change */
      *     dev_t          st_dev;        /* ID of device containing file    */
      *     size_t         st_blksize;    /* Size of a block of the file     */
      *     unsigned long  st_allocsize;  /* Allocation size of the file     */
      *     qp0l_objtype_t st_objtype;    /* AS/400 object type              */
      *     char           st_reserved3;  /* Reserved                    @B4A*/
      *     unsigned short st_codepage;   /* Object data codepage            */
      *     unsigned short st_ccsid;      /* Object data ccsid           @AAA*/
      *     dev_t          st_rdev;       /* Device ID (if character special */
      *                                   /* or block special file)      @B4A*/
      *     nlink32_t      st_nlink32;    /* Number of links-32 bit      @B5C*/
      *     dev64_t        st_rdev64;     /* Device ID - 64 bit form     @B4A*/
      *     dev64_t        st_dev64;      /* ID of device containing file -  */
      *                                   /* 64 bit form.                @B4A*/
      *     char           st_reserved1[36]; /* Reserved                 @B4A*/
      *     unsigned int   st_ino_gen_id; /* File serial number generation id
      *  };
      *                                                                  @A2A*/
      **********************************************************************
     D statds          DS                  qualified
     D                                     BASED(nullPointer)
     D  st_mode                      10U 0
     D  st_ino                       10U 0
     D  st_nlink                      5U 0
     D  st_reserved2                  5U 0
     D  st_uid                       10U 0
     D  st_gid                       10U 0
     D  st_size                      10I 0
     D  st_atime                     10I 0
     D  st_mtime                     10I 0
     D  st_ctime                     10I 0
     D  st_dev                       10U 0
     D  st_blksize                   10U 0
     D  st_allocsize                 10U 0
     D  st_objtype                   11A
     D  st_reserved3                  1A
     D  st_codepage                   5U 0
     D  st_ccsid                      5U 0
     D  st_rdev                      10U 0
     D  st_nlink32                   10U 0
     D  st_rdev64                    20U 0
     D  st_dev64                     20U 0
     D  st_reserved1                 36A
     D  st_ino_gen_id                10U 0


      **********************************************************************
      * File Information Structure, Large File Enabled (stat64)
      *   struct stat64 {                                                    */
      *     mode_t         st_mode;       /* File mode                       */
      *     ino_t          st_ino;        /* File serial number              */
      *     uid_t          st_uid;        /* User ID of the owner of file    */
      *     gid_t          st_gid;        /* Group ID of the group of fileA2A*/
      *     off64_t        st_size;       /* For regular files, the file     */
      *                                      size in bytes                   */
      *     time_t         st_atime;      /* Time of last access             */
      *     time_t         st_mtime;      /* Time of last data modification2A*/
      *     time_t         st_ctime;      /* Time of last file status changeA*/
      *     dev_t          st_dev;        /* ID of device containing file    */
      *     size_t         st_blksize;    /* Size of a block of the file     */
      *     nlink_t        st_nlink;      /* Number of links                 */
      *     unsigned short st_codepage;   /* Object data codepage            */
      *     unsigned long long st_allocsize; /* Allocation size of the file2A*/
      *     unsigned int   st_ino_gen_id; /* File serial number generationAid*/
      *                                                                      */
      *     qp0l_objtype_t st_objtype;    /* AS/400 object type              */
      *     char           st_reserved2[5]; /* Reserved                  @B4A*/
      *     dev_t          st_rdev;       /* Device ID (if character specialA*/
      *                                   /* or block special file)      @B4A*/
      *     dev64_t        st_rdev64;     /* Device ID - 64 bit form     @B4A*/
      *     dev64_t        st_dev64;      /* ID of device containing file@-2A*/
      *                                   /* 64 bit form.                @B4A*/
      *     nlink32_t      st_nlink32;    /* Number of links-32 bit      @B5A*/
      *     char           st_reserved1[26]; /* Reserved            @B4A @B5C*/
      *     unsigned short st_ccsid;      /* Object data ccsid           @AAA*/
      *  };                                                                  */
      *
      **********************************************************************
     D statds64        DS                  qualified
     D                                     BASED(nullPointer)
     D  st_mode                      10U 0
     D  st_ino                       10U 0
     D  st_uid                       10U 0
     D  st_gid                       10U 0
     D  st_size                      20I 0
     D  st_atime                     10I 0
     D  st_mtime                     10I 0
     D  st_ctime                     10I 0
     D  st_dev                       10U 0
     D  st_blksize                   10U 0
     D  st_nlink                      5U 0
     D  st_codepage                   5U 0
     D  st_allocsize                 20U 0
     D  st_ino_gen_id                10U 0
     D  st_objtype                   11A
     D  st_reserved2                  5A
     D  st_rdev                      10U 0
     D  st_rdev64                    20U 0
     D  st_dev64                     20U 0
     D  st_nlink32                   10U 0
     D  st_reserved1                 26A
     D  st_ccsid                      5U 0

      **********************************************************************
      * ds_statvfs - data structure to receive file system info
      *
      *   f_bsize   = file system block size (in bytes)
      *   f_frsize  = fundamental block size in bytes.
      *                if this is zero, f_blocks, f_bfree and f_bavail
      *                are undefined.
      *   f_blocks  = total number of blocks (in f_frsize)
      *   f_bfree   = total free blocks in filesystem (in f_frsize)
      *   f_bavail  = total blocks available to users (in f_frsize)
      *   f_files   = total number of file serial numbers
      *   f_ffree   = total number of unused file serial numbers
      *   f_favail  = number of available file serial numbers to users
      *   f_fsid    = filesystem ID.  This will be 4294967295 if it's
      *                too large for a 10U 0 field. (see f_fsid64)
      *   f_flag    = file system flags (see below)
      *   f_namemax = max filename length.  May be 4294967295 to
      *                indicate that there is no maximum.
      *   f_pathmax = max pathname legnth.  May be 4294967295 to
      *                indicate that there is no maximum.
      *   f_objlinkmax = maximum number of hard-links for objects
      *                other than directories
      *   f_dirlinkmax = maximum number of hard-links for directories
      *   f_fsid64  = filesystem id (in a 64-bit integer)
      *   f_basetype = null-terminated string containing the file
      *                  system type name.  For example, this might
      *                  be "root" or "Network File System (NFS)"
      *
      *  Since f_basetype is null-terminated, you should read it
      *  in ILE RPG with:
      *       myString = %str(%addr(ds_statvfs.f_basetype))
      **********************************************************************
     D ds_statvfs      DS                  qualified
     D                                     BASED(nullPointer)
     D  f_bsize                      10U 0
     D  f_frsize                     10U 0
     D  f_blocks                     20U 0
     D  f_bfree                      20U 0
     D  f_bavail                     20U 0
     D  f_files                      10U 0
     D  f_ffree                      10U 0
     D  f_favail                     10U 0
     D  f_fsid                       10U 0
     D  f_flag                       10U 0
     D  f_namemax                    10U 0
     D  f_pathmax                    10U 0
     D  f_objlinkmax                 10I 0
     D  f_dirlinkmax                 10I 0
     D  f_reserved1                   4A
     D  f_fsid64                     20U 0
     D  f_basetype                   80A


      **********************************************************************
      * Group Information Structure (group)
      *
      *  struct group {
      *        char    *gr_name;        /* Group name.                      */
      *        gid_t   gr_gid;          /* Group id.                        */
      *        char    **gr_mem;        /* A null-terminated list of pointers
      *                                    to the individual member names.  */
      *  };
      *
      **********************************************************************
     D group           DS                  qualified
     D                                     BASED(nullPointer)
     D   gr_name                       *
     D   gr_gid                      10U 0
     D   gr_mem                        *   DIM(256)


      **********************************************************************
      * User Information Structure (passwd)
      *
      * (Don't let the name fool you, this structure does not contain
      *  any password information.  Its named after the UNIX file that
      *  contains all of the user info.  That file is "passwd")
      *
      *   struct passwd {
      *        char    *pw_name;            /* User name.                   */
      *        uid_t   pw_uid;              /* User ID number.              */
      *        gid_t   pw_gid;              /* Group ID number.             */
      *        char    *pw_dir;             /* Initial working directory.   */
      *        char    *pw_shell;           /* Initial user program.        */
      *   };
      *
      **********************************************************************
     D passwd          DS                  qualified
     D                                     BASED(nullPointer)
     D  pw_name                        *
     D  pw_uid                       10U 0
     D  pw_gid                       10U 0
     D  pw_dir                         *
     D  pw_shell                       *


      **********************************************************************
      * File Time Structure (utimbuf)
      *
      * struct utimbuf {
      *    time_t     actime;           /*  access time       */
      *    time_t     modtime;          /*  modification time */
      * };
      *
      **********************************************************************
     D utimbuf         DS                  qualified
     D                                     BASED(nullPointer)
     D   actime                      10I 0
     D   modtime                     10I 0


      **********************************************************************
      * Directory Entry Structure (dirent)
      *
      * struct dirent {
      *   char           d_reserved1[16];  /* Reserved                       */
      *   unsigned int   d_fileno_gen_id   /* File number generation ID  @A1C*/
      *   ino_t          d_fileno;         /* The file number of the file    */
      *   unsigned int   d_reclen;         /* Length of this directory entry
      *                                     * in bytes                       */
      *   int            d_reserved3;      /* Reserved                       */
      *   char           d_reserved4[8];   /* Reserved                       */
      *   qlg_nls_t      d_nlsinfo;        /* National Language Information
      *                                     * about d_name                   */
      *   unsigned int   d_namelen;        /* Length of the name, in bytes
      *                                     * excluding NULL terminator      */
      *   char           d_name[_QP0L_DIR_NAME]; /* Name...null terminated   */
      *
      * };
      **********************************************************************
     D dirent          ds                  qualified
     D                                     BASED(nullPointer)
     D   d_reserv1                   16A
     D   d_fileno_gen_id...
     D                               10U 0
     D   d_fileno                    10U 0
     D   d_reclen                    10U 0
     D   d_reserv3                   10I 0
     D   d_reserv4                    8A
     D   d_nlsinfo                   12A
     D    d_nls_ccsid                10I 0 OVERLAY(d_nlsinfo:1)
     D    d_nls_cntry                 2A   OVERLAY(d_nlsinfo:5)
     D    d_nls_lang                  3A   OVERLAY(d_nlsinfo:7)
     D   d_namelen                   10U 0
     D   d_name                     640A

      **********************************************************************
      * I/O Vector Structure
      *
      *     struct iovec {
      *        void    *iov_base;
      *        size_t  iov_len;
      *     }
      **********************************************************************
     D iovec           DS                  qualified
     D                                     BASED(nullPointer)
     D  iov_base                       *
     D  iov_len                      10U 0

      *--------------------------------------------------------------------
      * Determine file accessibility
      *
      * int access(const char *path, int amode)
      *
      *--------------------------------------------------------------------
     D access          PR            10I 0 ExtProc('access')
     D   Path                          *   Value Options(*string)
     D   amode                       10I 0 Value


      *--------------------------------------------------------------------
      * Determine file accessibility for a class of users
      *
      * int accessx(const char *path, int amode, int who);
      *
      *--------------------------------------------------------------------
      /if defined(*V5R2M0)
     D accessx         PR            10I 0 ExtProc('accessx')
     D   Path                          *   Value Options(*string)
     D   amode                       10I 0 Value
     D   who                         10I 0 value
      /endif

      *--------------------------------------------------------------------
      * Change Directory
      *
      * int chdir(const char *path)
      *--------------------------------------------------------------------
     D chdir           PR            10I 0 ExtProc('chdir')
     D   path                          *   Value Options(*string)

      *--------------------------------------------------------------------
      * Change file authorizations
      *
      * int chmod(const char *path, mode_t mode)
      *--------------------------------------------------------------------
     D chmod           PR            10I 0 ExtProc('chmod')
     D   path                          *   Value options(*string)
     D   mode                        10U 0 Value

      *--------------------------------------------------------------------
      * Change Owner/Group of File
      *
      * int chown(const char *path, uid_t owner, gid_t group)
      *--------------------------------------------------------------------
     D chown           PR            10I 0 ExtProc('chown')
     D   path                          *   Value options(*string)
     D   owner                       10U 0 Value
     D   group                       10U 0 Value

      *--------------------------------------------------------------------
      * Close a file
      *
      * int close(int fildes)
      *
      * Note:  Because the same close() API is used for IFS, sockets,
      *        and pipes, it's conditionally defined here.  If it's
      *        done the same in the sockets & pipe /copy members,
      *        there will be no conflict.
      *--------------------------------------------------------------------
     D/if not defined(CLOSE_PROTOTYPE)
     D close           PR            10I 0 ExtProc('close')
     D  fildes                       10I 0 value
     D/define CLOSE_PROTOTYPE
     D/endif

      *--------------------------------------------------------------------
      * Close a directory
      *
      * int closedir(DIR *dirp)
      *--------------------------------------------------------------------
     D closedir        PR            10I 0 EXTPROC('closedir')
     D  dirp                           *   VALUE

      *--------------------------------------------------------------------
      * Create or Rewrite File
      *
      * int creat(const char *path, mode_t mode)
      *
      * DEPRECATED:  Use open() instead.
      *--------------------------------------------------------------------
     D creat           PR            10I 0 ExtProc('creat')
     D   path                          *   Value options(*string)
     D   mode                        10U 0 Value

      *--------------------------------------------------------------------
      * Duplicate open file descriptor
      *
      * int dup(int fildes)
      *--------------------------------------------------------------------
     D dup             PR            10I 0 ExtProc('dup')
     D   fildes                      10I 0 Value

      *--------------------------------------------------------------------
      * Duplicate open file descriptor to another descriptor
      *
      * int dup2(int fildes, int fildes2)
      *--------------------------------------------------------------------
     D dup2            PR            10I 0 ExtProc('dup2')
     D   fildes                      10I 0 Value
     D   fildes2                     10I 0 Value

      *--------------------------------------------------------------------
      * Determine file accessibility for a class of users by descriptor
      *
      * int faccessx(int filedes, int amode, int who)
      *--------------------------------------------------------------------
      /if defined(*V5R2M0)
     D faccessx        PR            10I 0 ExtProc('faccessx')
     D   fildes                      10I 0 Value
     D   amode                       10I 0 Value
     D   who                         10I 0 Value
      /endif

      *--------------------------------------------------------------------
      * Change Current Directory by Descriptor
      *
      * int fchdir(int fildes)
      *--------------------------------------------------------------------
      /if defined(*V5R2M0)
     D fchdir          PR            10I 0 ExtProc('fchdir')
     D   fildes                      10I 0 value
      /endif

      *--------------------------------------------------------------------
      * Change file authorizations by descriptor
      *
      * int fchmod(int fildes, mode_t mode)
      *--------------------------------------------------------------------
     D fchmod          PR            10I 0 ExtProc('fchmod')
     D   fildes                      10I 0 Value
     D   mode                        10U 0 Value

      *--------------------------------------------------------------------
      * Change Owner and Group of File by Descriptor
      *
      * int fchown(int fildes, uid_t owner, gid_t group)
      *--------------------------------------------------------------------
     D fchown          PR            10I 0 ExtProc('fchown')
     D   fildes                      10I 0 Value
     D   owner                       10U 0 Value
     D   group                       10U 0 Value

      *--------------------------------------------------------------------
      * Perform File Control
      *
      * int fcntl(int fildes, int cmd, . . .)
      *
      * Note:  Because the same fcntl() API is used for IFS and sockets,
      *        it's conditionally defined here.  If it's defined with
      *        the same conditions in the sockets /copy member, there
      *        will be no conflict.
      *--------------------------------------------------------------------
     D/if not defined(FCNTL_PROTOTYPE)
     D fcntl           PR            10I 0 ExtProc('fcntl')
     D   fildes                      10I 0 Value
     D   cmd                         10I 0 Value
     D   arg                         10I 0 Value options(*nopass)
     D/define FCNTL_PROTOTYPE
     D/endif

      *--------------------------------------------------------------------
      * Get configurable path name variables by descriptor
      *
      * long fpathconf(int fildes, int name)
      *--------------------------------------------------------------------
     D fpathconf       PR            10I 0 ExtProc('fpathconf')
     D   fildes                      10I 0 Value
     D   name                        10I 0 Value

      *--------------------------------------------------------------------
      * Get File Information by Descriptor
      *
      * int fstat(int fildes, struct stat *buf)
      *--------------------------------------------------------------------
     D fstat           PR            10I 0 ExtProc('fstat')
     D   fildes                      10I 0 Value
     D   buf                               likeds(statds)

      *--------------------------------------------------------------------
      * Get File Information by Descriptor, Large File Enabled
      *
      * int fstat64(int fildes, struct stat *buf)
      *--------------------------------------------------------------------
     D fstat64         PR            10I 0 ExtProc('fstat64')
     D   fildes                      10I 0 Value
     D   buf                               likeds(statds64)

      *--------------------------------------------------------------------
      * fstatvfs() -- Get file system status by descriptor
      *
      *  fildes = (input) file descriptor to use to locate file system
      *     buf = (output) data structure containing file system info
      *
      * Returns 0 if successful, -1 upon error.
      * (error information is returned via the "errno" variable)
      *--------------------------------------------------------------------
     D fstatvfs        PR            10I 0 ExtProc('fstatvfs64')
     D   fildes                      10I 0 value
     D   buf                               like(ds_statvfs)

      *--------------------------------------------------------------------
      * Synchronize Changes to file
      *
      * int fsync(int fildes)
      *--------------------------------------------------------------------
     D fsync           PR            10I 0 ExtProc('fsync')
     D   fildes                      10I 0 Value

      *--------------------------------------------------------------------
      * Truncate file
      *
      * int ftruncate(int fildes, off_t length)
      *--------------------------------------------------------------------
     D ftruncate       PR            10I 0 ExtProc('ftruncate')
     D   fildes                      10I 0 Value
     D   length                      10I 0 Value

      *--------------------------------------------------------------------
      * Truncate file, large file enabled
      *
      * int ftruncate64(int fildes, off64_t length)
      *--------------------------------------------------------------------
     D ftruncate64     PR            10I 0 ExtProc('ftruncate64')
     D   fildes                      10I 0 Value
     D   length                      20I 0 Value

      *--------------------------------------------------------------------
      * Get current working directory
      *
      * char *getcwd(char *buf, size_t size)
      *--------------------------------------------------------------------
     D getcwd          PR              *   ExtProc('getcwd')
     D   buf                           *   Value
     D   size                        10U 0 Value

      *--------------------------------------------------------------------
      * Get effective group ID
      *
      * gid_t getegid(void)
      *--------------------------------------------------------------------
     D getegid         PR            10U 0 ExtProc('getegid')

      *--------------------------------------------------------------------
      * Get effective user ID
      *
      * uid_t geteuid(void)
      *--------------------------------------------------------------------
     D geteuid         PR            10U 0 ExtProc('geteuid')

      *--------------------------------------------------------------------
      * Get Real Group ID
      *
      * gid_t getgid(void)
      *--------------------------------------------------------------------
     D getgid          PR            10U 0 ExtProc('getgid')

      *--------------------------------------------------------------------
      * Get group information from group ID
      *
      * struct group *getgrgid(gid_t gid)
      *--------------------------------------------------------------------
     D getgrgid        PR              *   ExtProc('getgrgid')
     D   gid                         10U 0 VALUE

      *--------------------------------------------------------------------
      * Get group info using group name
      *
      * struct group  *getgrnam(const char *name)
      *--------------------------------------------------------------------
     D getgrnam        PR              *   ExtProc('getgrnam')
     D   name                          *   VALUE

      *--------------------------------------------------------------------
      * Get group IDs
      *
      * int getgroups(int gidsetsize, gid_t grouplist[])
      *--------------------------------------------------------------------
     D getgroups       PR              *   ExtProc('getgroups')
     D   gidsetsize                  10I 0 value
     D   grouplist                   10U 0 dim(256) options(*varsize)

      *--------------------------------------------------------------------
      * Get user information by user-name
      *
      * (Don't let the name mislead you, this does not return the password,
      *  the user info database on unix systems is called "passwd",
      *  therefore, getting the user info is called "getpw")
      *
      * struct passwd *getpwnam(const char *name)
      *--------------------------------------------------------------------
     D getpwnam        PR              *   ExtProc('getpwnam')
     D   name                          *   Value options(*string)

      *--------------------------------------------------------------------
      * Get user information by user-id number
      *
      * (Don't let the name mislead you, this does not return the password,
      *  the user info database on unix systems is called "passwd",
      *  therefore, getting the user info is called "getpw")
      *
      * struct passwd *getpwuid(uid_t uid)
      *--------------------------------------------------------------------
     D getpwuid        PR              *   extproc('getpwuid')
     D   uid                         10U 0 Value

      *--------------------------------------------------------------------
      * Get Real User-ID
      *
      * uid_t getuid(void)
      *--------------------------------------------------------------------
     D getuid          PR            10U 0 ExtProc('getuid')

      *--------------------------------------------------------------------
      * Perform I/O Control Request
      *
      * int ioctl(int fildes, unsigned long req, ...)
      *--------------------------------------------------------------------
     D ioctl           PR            10I 0 ExtProc('ioctl')
     D   fildes                      10I 0 Value
     D   req                         10U 0 Value
     D   arg                           *   Value

      *--------------------------------------------------------------------
      * Change Owner/Group of symbolic link
      *
      * int lchown(const char *path, uid_t owner, gid_t group)
      *
      * NOTE: for non-symlinks, this behaves identically to chown().
      *       for symlinks, this changes ownership of the link, whereas
      *       chown() changes ownership of the file the link points to.
      *--------------------------------------------------------------------
     D lchown          PR            10I 0 ExtProc('lchown')
     D   path                          *   Value options(*string)
     D   owner                       10U 0 Value
     D   group                       10U 0 Value

      *--------------------------------------------------------------------
      * Create Hard Link to File
      *
      * int link(const char *existing, const char *new)
      *--------------------------------------------------------------------
     D link            PR            10I 0 ExtProc('link')
     D   existing                      *   Value options(*string)
     D   new                           *   Value options(*string)

      *--------------------------------------------------------------------
      * Set File Read/Write Offset
      *
      * off_t lseek(int fildes, off_t offset, int whence)
      *--------------------------------------------------------------------
     D lseek           PR            10I 0 ExtProc('lseek')
     D   fildes                      10I 0 value
     D   offset                      10I 0 value
     D   whence                      10I 0 value

      *--------------------------------------------------------------------
      * Set File Read/Write Offset, Large File Enabled
      *
      * off64_t lseek64(int fildes, off64_t offset, int whence)
      *--------------------------------------------------------------------
     D lseek64         PR            20I 0 ExtProc('lseek64')
     D   fildes                      10I 0 value
     D   offset                      20I 0 value
     D   whence                      10I 0 value

      *--------------------------------------------------------------------
      * Get File or Link Information
      *
      * int lstat(const char *path, struct stat *buf)
      *
      * NOTE: for non-symlinks, this behaves identically to stat().
      *       for symlinks, this gets information about the link, whereas
      *       stat() gets information about the file the link points to.
      *--------------------------------------------------------------------
     D lstat           PR            10I 0 ExtProc('lstat')
     D   path                          *   Value options(*string)
     D   buf                               likeds(statds)

      *--------------------------------------------------------------------
      * Get File or Link Information, Large File Enabled
      *
      * int lstat64(const char *path, struct stat64 *buf)
      *
      * NOTE: for non-symlinks, this behaves identically to stat().
      *       for symlinks, this gets information about the link, whereas
      *       stat() gets information about the file the link points to.
      *--------------------------------------------------------------------
     D lstat64         PR            10I 0 ExtProc('lstat64')
     D   path                          *   Value options(*string)
     D   buf                               likeds(statds64)

      *--------------------------------------------------------------------
      * Make Directory
      *
      * int mkdir(const char *path, mode_t mode)
      *--------------------------------------------------------------------
     D mkdir           PR            10I 0 ExtProc('mkdir')
     D   path                          *   Value options(*string)
     D   mode                        10U 0 Value

      *--------------------------------------------------------------------
      * Make FIFO Special File
      *
      * int mkfifo(const char *path, mode_t mode)
      *--------------------------------------------------------------------
      /if defined(*V5R1M0)
     D mkfifo          PR            10I 0 ExtProc('mkfifo')
     D   path                          *   Value options(*string)
     D   mode                        10U 0 Value
      /endif

      *--------------------------------------------------------------------
      * Open a File
      *
      * int open(const char *path, int oflag, . . .);
      *--------------------------------------------------------------------
     D open            PR            10I 0 ExtProc('open')
     D  path                           *   value options(*string)
     D  openflags                    10I 0 value
     D  mode                         10U 0 value options(*nopass)
     D  ccsid                        10U 0 value options(*nopass)
     D/if defined(*V5R2M0)
     D  txtcreatid                   10U 0 value options(*nopass)
     D/endif

      *--------------------------------------------------------------------
      * Open a File, Large File Enabled
      *
      * int open64(const char *path, int oflag, . . .);
      *
      * NOTE: This is identical to calling open(), except that the
      *       O_LARGEFILE flag is automatically supplied.
      *--------------------------------------------------------------------
     D open64          PR            10I 0 ExtProc('open64')
     D  filename                       *   value options(*string)
     D  openflags                    10I 0 value
     D  mode                         10U 0 value options(*nopass)
     D  codepage                     10U 0 value options(*nopass)
     D/if defined(*V5R2M0)
     D  txtcreatid                   10U 0 value options(*nopass)
     D/endif

      *--------------------------------------------------------------------
      * Open a Directory
      *
      * DIR *opendir(const char *dirname)
      *--------------------------------------------------------------------
     D opendir         PR              *   EXTPROC('opendir')
     D  dirname                        *   VALUE options(*string)

      *--------------------------------------------------------------------
      * Get configurable path name variables
      *
      * long pathconf(const char *path, int name)
      *--------------------------------------------------------------------
     D pathconf        PR            10I 0 ExtProc('pathconf')
     D   path                          *   Value options(*string)
     D   name                        10I 0 Value

      *--------------------------------------------------------------------
      * Create interprocess channel
      *
      * int pipe(int fildes[2]);
      *--------------------------------------------------------------------
     D pipe            PR            10I 0 ExtProc('pipe')
     D   fildes                      10I 0 dim(2)

      *--------------------------------------------------------------------
      * Read from Descriptor with Offset
      *
      * ssize_t pread(int filedes, void *buf, size_t nbyte, off_t offset);
      *--------------------------------------------------------------------
      /if defined(*V5R2M0)
     D pread           PR            10I 0 ExtProc('pread')
     D   fildes                      10I 0 value
     D   buf                           *   value
     D   nbyte                       10U 0 value
     D   offset                      10I 0 value
      /endif

      *--------------------------------------------------------------------
      * Read from Descriptor with Offset, Large File Enabled
      *
      * ssize_t pread64(int filedes, void *buf, size_t nbyte,
      *                 size_t nbyte, off64_t offset);
      *--------------------------------------------------------------------
      /if defined(*V5R2M0)
     D pread64         PR            10I 0 ExtProc('pread64')
     D   fildes                      10I 0 value
     D   buf                           *   value
     D   nbyte                       10U 0 value
     D   offset                      20I 0 value
      /endif

      *--------------------------------------------------------------------
      * Write to Descriptor with Offset
      *
      * ssize_t pwrite(int filedes, const void *buf,
      *                size_t nbyte, off_t offset);
      *--------------------------------------------------------------------
      /if defined(*V5R2M0)
     D pwrite          PR            10I 0 ExtProc('pwrite')
     D   fildes                      10I 0 value
     D   buf                           *   value
     D   nbyte                       10U 0 value
     D   offset                      10I 0 value
      /endif

      *--------------------------------------------------------------------
      * Write to Descriptor with Offset, Large File Enabled
      *
      * ssize_t pwrite64(int filedes, const void *buf,
      *                  size_t nbyte, off64_t offset);
      *--------------------------------------------------------------------
      /if defined(*V5R2M0)
     D pwrite64        PR            10I 0 ExtProc('pwrite64')
     D   fildes                      10I 0 value
     D   buf                           *   value
     D   nbyte                       10U 0 value
     D   offset                      20I 0 value
      /endif

      *--------------------------------------------------------------------
      * Perform Miscellaneous file system functions
      *--------------------------------------------------------------------
     D QP0FPTOS        PR                  ExtPgm('QP0FPTOS')
     D   Function                    32A   const
     D   Exten1                       6A   const options(*nopass)
     D   Exten2                       3A   const options(*nopass)

      *--------------------------------------------------------------------
      * Read From a File
      *
      * ssize_t read(int fildes, void *buffer, size_t bytes);
      *--------------------------------------------------------------------
     D read            PR            10I 0 ExtProc('read')
     D  fildes                       10i 0 value
     D  buf                            *   value
     D  bytes                        10U 0 value

      *--------------------------------------------------------------------
      * Read Directory Entry
      *
      * struct dirent *readdir(DIR *dirp)
      *--------------------------------------------------------------------
     D readdir         PR              *   EXTPROC('readdir')
     D  dirp                           *   VALUE

      *--------------------------------------------------------------------
      * Read Value of Symbolic Link
      *
      * int readlink(const char *path, char *buf, size_t bufsiz)
      *--------------------------------------------------------------------
     D readlink        PR            10I 0 ExtProc('readlink')
     D   path                          *   value options(*string)
     D   buf                           *   value
     D   bufsiz                      10U 0 value

      *--------------------------------------------------------------------
      * Read From Descriptor using Multiple Buffers
      *
      * int readv(int fildes, struct iovec *io_vector[], int vector_len);
      *--------------------------------------------------------------------
     D readv           PR            10I 0 ExtProc('readv')
     D  fildes                       10i 0 value
     D  io_vector                          like(iovec)
     D                                     dim(256) options(*varsize)
     D  vector_len                   10I 0 value

      *--------------------------------------------------------------------
      * Rename File or Directory
      *
      * int rename(const char *old, const char *new)
      *
      *  Note: By defailt, if a file with the new name already exists,
      *        rename will fail with an error.  If you define
      *        RENAMEUNLINK and a file with the new name already exists
      *        it will be unlinked prior to renaming.
      *--------------------------------------------------------------------
      /if defined(RENAMEUNLINK)
     D rename          PR            10I 0 ExtProc('Qp0lRenameUnlink')
     D   old                           *   Value options(*string)
     D   new                           *   Value options(*string)
      /else
     D rename          PR            10I 0 ExtProc('Qp0lRenameKeep')
     D   old                           *   Value options(*string)
     D   new                           *   Value options(*string)
      /endif

      *--------------------------------------------------------------------
      * Reset Directory Stream to Beginning
      *
      * void rewinddir(DIR *dirp)
      *--------------------------------------------------------------------
     D rewinddir       PR                  ExtProc('rewinddir')
     D   dirp                          *   value


      *--------------------------------------------------------------------
      * Remove Directory
      *
      * int rmdir(const char *path)
      *--------------------------------------------------------------------
     D rmdir           PR            10I 0 ExtProc('rmdir')
     D   path                          *   value options(*string)

      *--------------------------------------------------------------------
      * Get File Information
      *
      * int stat(const char *path, struct stat *buf)
      *--------------------------------------------------------------------
     D stat            PR            10I 0 ExtProc('stat')
     D   path                          *   value options(*string)
     D   buf                               likeds(statds)


      *--------------------------------------------------------------------
      * Get File Information, Large File Enabled
      *
      * int stat(const char *path, struct stat64 *buf)
      *--------------------------------------------------------------------
     D stat64          PR            10I 0 ExtProc('stat64')
     D   path                          *   value options(*string)
     D   buf                               likeds(statds64)


      *--------------------------------------------------------------------
      * statvfs() -- Get file system status
      *
      *    path = (input) pathname of a link ("file") in the IFS.
      *     buf = (output) data structure containing file system info
      *
      * Returns 0 if successful, -1 upon error.
      * (error information is returned via the "errno" variable)
      *--------------------------------------------------------------------
     D statvfs         PR            10I 0 ExtProc('statvfs64')
     D   path                          *   value options(*string)
     D   buf                               like(ds_statvfs)

      *--------------------------------------------------------------------
      * Make Symbolic Link
      *
      * int symlink(const char *pname, const char *slink)
      *--------------------------------------------------------------------
     D symlink         PR            10I 0 ExtProc('symlink')
     D   pname                         *   value options(*string)
     D   slink                         *   value options(*string)

      *--------------------------------------------------------------------
      * Get system configuration variables
      *
      * long sysconf(int name)
      *--------------------------------------------------------------------
     D sysconf         PR            10I 0 ExtProc('sysconf')
     D   name                        10I 0 Value

      *--------------------------------------------------------------------
      * Set Authorization Mask for Job
      *
      * mode_t umask(mode_t cmask)
      *--------------------------------------------------------------------
     D umask           PR            10U 0 ExtProc('umask')
     D   cmask                       10U 0 Value

      *--------------------------------------------------------------------
      * Remove Link to File.  (Deletes Directory Entry for File, and if
      *    this was the last link to the file data, the file itself is
      *    also deleted)
      *
      * int unlink(const char *path)
      *--------------------------------------------------------------------
     D unlink          PR            10I 0 ExtProc('unlink')
     D   path                          *   Value options(*string:*trim)

      *--------------------------------------------------------------------
      * Set File Access & Modification Times
      *
      * int utime(const char *path, const struct utimbuf *times)
      *--------------------------------------------------------------------
     D utime           PR            10I 0 ExtProc('utime')
     D   path                          *   value options(*string)
     D   times                             likeds(utimbuf) options(*omit)

      *--------------------------------------------------------------------
      * Write to a file
      *
      * ssize_t write(int fildes, const void *buf, size_t bytes)
      *--------------------------------------------------------------------
     D write           PR            10I 0 ExtProc('write')
     D  fildes                       10i 0 value
     D  buf                            *   value
     D  bytes                        10U 0 value

      *--------------------------------------------------------------------
      * Write to a file using (with type A field in prototype)
      *
      * ssize_t write(int fildes, const void *buf, size_t bytes)
      *--------------------------------------------------------------------
     D writeA          PR            10I 0 ExtProc('write')
     D  fildes                       10i 0 value
     D  buf                       65535A   const options(*varsize)
     D  bytes                        10U 0 value

      *--------------------------------------------------------------------
      * Write to descriptor using multiple buffers
      *
      * int writev(int fildes, struct iovec *iovector[], int vector_len);
      *--------------------------------------------------------------------
     D writev          PR            10I 0 ExtProc('writev')
     D  fildes                       10i 0 value
     D  io_vector                          like(iovec)
     D                                     dim(256) options(*varsize)
     D  vector_len                   10I 0 value


     D remove          PR            10I 0 extproc('remove')
     D  path                           *   value options(*string)
 