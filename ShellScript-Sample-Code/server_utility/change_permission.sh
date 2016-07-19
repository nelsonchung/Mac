#!/bin/bash
source /home/nelson/server_utility/common.source
#change permission first or backup will fail.
chown -R backup ${wimax_archive}
chgrp -R backup ${wimax_archive}
chmod -R 777 ${wimax_archive}
chown -R backup ${vplayer_archive}
chgrp -R backup ${vplayer_archive}
chmod -R 777 ${vplayer_archive}
#chown -R backup ${release_folder_path}
#chgrp -R backup ${release_folder_path}
#chmod -R 777 ${release_folder_path}
#chown -R backup ${resource_folder_path}
#chgrp -R backup ${resource_folder_path}
#chmod -R 777 ${resource_folder_path}
