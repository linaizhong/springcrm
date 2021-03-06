/*
 * InvoicingTransactionXMLFactory.groovy
 *
 * Copyright (c) 2011-2016, Daniel Ellermann
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


package org.amcworld.springcrm.xml

import com.naleid.grails.MarkdownService
import org.amcworld.springcrm.InvoicingTransaction
import org.amcworld.springcrm.User


/**
 * The class {@code InvoicingTransactionXMLFactory} represents a factory to
 * create XML converters for invoicing transactions.
 *
 * @author  Daniel Ellermann
 * @version 2.1
 * @since   1.4
 */
class InvoicingTransactionXMLFactory {

    //-- Fields ---------------------------------

    MarkdownService markdownService


    //-- Public methods -------------------------

    /**
     * Creates a new XML converter for the given invoicing transaction.
     *
     * @param transaction   the given invoicing transaction
     * @param user          the currently logged in user
     * @return              the XML converter
     */
    InvoicingTransactionXML newConverter(InvoicingTransaction transaction,
                                         User user)
    {
        def inst = new InvoicingTransactionXML(transaction, user)
        inst.markdownService = markdownService

        inst
    }
}
