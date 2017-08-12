#  nixos-mailserver: a simple mail server
#  Copyright (C) 2016-2017  Robin Raymond
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <http://www.gnu.org/licenses/>

{ mail_dir, vmail_user_name, vmail_group_name, valiases, domain, enable_imap,
enable_pop3, virus_scanning, dkim_signing, certificate_scheme, cert_file,
key_file }:

{
  # rspamd
  rspamd = {
    enable = true;
  };

  rmilter = import ./rmilter.nix {
    inherit domain virus_scanning dkim_signing;
  };

  postfix = import ./postfix.nix {
    inherit mail_dir domain valiases certificate_scheme cert_file key_file;
  };

  dovecot2 = import ./dovecot.nix {
    inherit vmail_group_name vmail_user_name mail_dir enable_imap
            enable_pop3 certificate_scheme cert_file key_file;
  };
}
