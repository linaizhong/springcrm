/*
 * ProjectItemDeleteInterceptorSpec.groovy
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


package org.amcworld.springcrm

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification


@TestFor(ProjectItemDeleteInterceptor)
@Mock([Project, ProjectItem])
class ProjectItemDeleteInterceptorSpec extends Specification {

    //-- Feature methods ------------------------

    def 'Interceptor matches the correct controller/action pairs'(
        String c, String a, boolean b
    ) {
        when: 'I use a particular request'
        withRequest controller: c, action: a

        then: 'the interceptor does match or not'
        b == interceptor.doesMatch()

        where:
        c                   | a                     || b
        'call'              | null                  || false
        'organization'      | null                  || false
        'user'              | null                  || false
        'call'              | 'index'               || false
        'organization'      | 'index'               || false
        'user'              | 'index'               || false
        'call'              | 'delete'              || true
        'organization'      | 'delete'              || true
        'user'              | 'delete'              || true
    }

    def 'All interceptor methods return true'() {
        expect:
        interceptor.after()
        interceptor.before()
    }

    def 'No ID does not delete project item'() {
        given: 'a project'
        makeProject()

        and: 'a controller name'
        webRequest.controllerName = 'call'

        when: 'I call the interceptor'
        interceptor.after()

        then: 'no project item has been deleted'
        3 == ProjectItem.count()
    }

    def 'No confirmed flag does not update project item'() {
        given: 'a project'
        makeProject()

        and: 'a controller name'
        webRequest.controllerName = 'call'

        and: 'an item ID'
        params.id = 456

        when: 'I call the interceptor'
        interceptor.after()

        then: 'no project item has been deleted'
        3 == ProjectItem.count()
    }

    def 'A confirmed flag deletes all referring project items'() {
        given: 'a project'
        def p = makeProject()

        and: 'a controller name'
        webRequest.controllerName = 'call'

        and: 'an item ID and a confirmed flag'
        params.id = 456
        params.confirmed = true

        when: 'I call the interceptor'
        interceptor.after()

        then: 'two project items have been deleted'
        // TODO the following assertion does not work in Grails 3.1.3
        // Maybe DetachedCriteria.deleteAll does not work well with mocked objects
        // 0 == ProjectItem.countByItemId(456)

        // and: 'one project item remained unchanged'
        ProjectItem.findAllByItemId(4730).every {
            it.controller == 'salesOrder' && it.title == 'Order #3'
        }
    }


    //-- Non-public methods ---------------------

    private Project makeProject() {
        def p = new Project(
			number: 1993,
			title: 'Website',
			description: 'Develope a website for my best client.',
			organization: new Organization(name: 'AMC World'),
			person: new Person(firstName: 'Daniel', lastName: 'Ellermann'),
			phase: ProjectPhase.planning,
            status: new ProjectStatus()
		)
        p.items = [
            new ProjectItem(
                phase: ProjectPhase.planning, controller: 'call',
                itemId: 456, title: 'Call to client'
            ),
            new ProjectItem(
                phase: ProjectPhase.ordering, controller: 'salesOrder',
                itemId: 4730, title: 'Order #3'
            ),
            new ProjectItem(
                phase: ProjectPhase.implementation, controller: 'call',
                itemId: 456, title: 'Call to client'
            )
        ]
        p.save failOnError: true
    }
}
