/*
 * LdapService.groovy
 *
 * Copyright (c) 2011-2013, Daniel Ellermann
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


package org.amcworld.springcrm

import javax.naming.NameAlreadyBoundException
import org.apache.directory.groovyldap.LDAP


/**
 * The class {@code LdapService} contains methods to communicate with an LDAP
 * server and store person data.
 *
 * @author  Daniel Ellermann
 * @version 1.3
 */
class LdapService {

	//-- Class variables ------------------------

    static transactional = false


	//-- Public methods -------------------------

	/**
	 * Deletes the given person from the LDAP directory.
	 *
	 * @param p	the person to delete
	 */
	void delete(Person p) {
		def ldap = getLdap()
		if (ldap) {
			LdapSyncStatus status = LdapSyncStatus.findByItemId(p.id)
			if (status) {
				if (ldap.exists(status.dn)) {
					log.debug "Deleting DN ${status.dn} from LDAP..."
					ldap.delete(status.dn)
				}
				status.delete(flush:true)
			}
		}
	}

	/**
	 * Saves the given person to the LDAP directory. The method either creates
	 * or updates an entry in the directory.
	 *
	 * @param p	the person to save
	 */
	void save(Person p) {
		def ldap = getLdap()
		if (ldap) {
			log.debug "Exporting person ${p} to LDAP..."
			LdapSyncStatus status = LdapSyncStatus.findByItemId(p.id)
			if (status) {
				if (ldap.exists(status.dn)) {
					log.debug "DN ${status.dn} already exists -> deleting it."
					ldap.delete(status.dn)
				}
			} else {
				status = new LdapSyncStatus(itemId:p.id)
			}
			def attrs = convertPersonToAttrs(p)
			StringBuilder cn
			for (int i = 1; i < 10000; i++) {	// 10000 => emergency abort
				cn = new StringBuilder('cn=')
				cn << attrs.cn
				if (i > 1) {
					cn << ' ' << i
				}
				cn << ',' << (config['ldapContactDn'] as String)
				try {
					log.debug "Trying to save DN ${cn} to LDAP..."
					ldap.add(cn.toString(), attrs)
					status.dn = cn.toString()
					status.save(flush:true)
					break
				} catch (NameAlreadyBoundException ignored) { /* ignored */ }
			}
			log.debug "Successfully exported person ${p} to LDAP."
		}
	}


	//-- Non-public methods ---------------------

	/**
	 * Converts the given person to an attribute map which can be transferred
	 * to the LDAP directory.
	 *
	 * @param p	the person to convert
	 * @return	the attribute map containing the person property values
	 * 			suitable for LDAP
	 */
	protected Map convertPersonToAttrs(Person p) {
	    def attrs = [
		    cn: "${p.lastName} ${p.firstName}".toString(),
		    displayname: "${p.firstName} ${p.lastName}".toString(),
		    givenname: p.firstName,
		    o: p.organization.name,
		    objectclass: ['top', 'inetOrgPerson'],
		    sn: p.lastName
	    ]
		if (p.organization.industry) {
			attrs.businesscategory = p.organization.industry.name
		}
		List<String> l = new ArrayList<String>()
		if (p.fax) {
			l.add p.fax
		}
		if (p.organization.fax && p.organization.fax != p.fax) {
			l.add p.organization.fax
		}
		if (!l.isEmpty()) {
			attrs.facsimiletelephonenumber = l.unique {
				it.replaceAll(~/\D/, '')
			}
		}
	    if (p.phoneHome) {
			attrs.homephone = p.phoneHome
	    }
		if (p.mailingAddrLocation) {
			attrs.l = p.mailingAddrLocation
		}
	    if (p.organization.website) {
			attrs.labeleduri = p.organization.website
	    }
		l = new ArrayList<String>()
		if (p.email1) {
			l.add p.email1
		}
		if (p.organization.email1 && p.organization.email1 != p.email1) {
			l.add p.organization.email1
		}
		if (p.email2) {
			l.add p.email2
		}
		if (p.organization.email2 && p.organization.email2 != p.email2) {
			l.add p.organization.email2
		}
		if (!l.isEmpty()) {
			attrs.mail = l.unique()
		}
	    if (p.mobile) {
			attrs.mobile = p.mobile
	    }
	    if (p.department) {
			attrs.ou = p.department
	    }
		String s = p.mailingAddr
		if (s) {
			attrs.postaladdress = s
		}
		if (p.mailingAddrPostalCode) {
			attrs.postalcode = p.mailingAddrPostalCode
		}
		if (p.mailingAddrPoBox) {
			attrs.postofficebox = p.mailingAddrPoBox
		}
		if (p.mailingAddrState) {
			attrs.st = p.mailingAddrState
		}
		if (p.mailingAddrStreet) {
			attrs.street = p.mailingAddrStreet
		}
		l = new ArrayList<String>()
		if (p.phone) {
			l.add p.phone
		}
		if (p.organization.phone && p.organization.phone != p.phone) {
			l.add p.organization.phone
		}
		if (p.phoneOther) {
			l.add p.phoneOther
		}
		if (p.organization.phoneOther
			&& p.organization.phoneOther != p.phoneOther)
		{
			l.add p.organization.phoneOther
		}
		if (!l.isEmpty()) {
			attrs.telephonenumber = l.unique {
				it.replaceAll(~/\D/, '')
			}
		}
		return attrs
	}

	/**
	 * Gets the configuration data from the application wide configuration
	 * holder.
	 *
	 * @return	the configuration holder
	 */
	protected ConfigHolder getConfig() {
		return ConfigHolder.instance
	}

	/**
	 * Gets the connection handle to the LDAP server. The attributes such as
	 * host name, port, bind name, and password are obtained from the
	 * configuration holder.
	 *
	 * @return	the LDAP server connection; <code>null</code> if no LDAP server
	 * 			is configured
	 */
	protected LDAP getLdap() {
		LDAP ldap = null
		String host = config['ldapHost'] as String
		if (host) {
			StringBuilder buf = new StringBuilder('ldap://')
			buf << host
            Integer port = config['ldapPort'] as Integer
			if (port) {
				buf << ':' << port
			}
			ldap = LDAP.newInstance(
				buf.toString(), config['ldapBindDn'] as String,
                config['ldapBindPasswd'] as String
		    )
		}
		return ldap
	}
}
