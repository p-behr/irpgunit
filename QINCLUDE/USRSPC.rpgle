      /if not defined (IRPGUNIT_USRSPC)
      /define IRPGUNIT_USRSPC
      // ==========================================================================
      //  iRPGUnit - User Space Utilities.
      // ==========================================================================
      //  Copyright (c) 2013-2019 iRPGUnit Project Team
      //  All rights reserved. This program and the accompanying materials
      //  are made available under the terms of the Common Public License v1.0
      //  which accompanies this distribution, and is available at
      //  http://www.eclipse.org/legal/cpl-v10.html
      // ==========================================================================

      //
      // Prototypes for USRSPC.
      //

       // Creates a User Space. Returns a pointer to it.
     D crtUsrSpc       pr              *   extproc('USRSPC_+
     D                                     crtUsrSpc+
     D                                     ')
        // qualified user space name.
     D  usrSpc                             const likeds(Object_t)
        // User space text description.
     D  text                         50a   const

      /endif 