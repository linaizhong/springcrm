/*
 * SalesItemPricing.groovy
 *
 * Copyright (c) 2011-2012, Daniel Ellermann
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


/**
 * The class {@code SalesItemPricing} represents a pricing for a sales item
 * such as a product or service.
 *
 * @author	Daniel Ellermann
 * @version 1.3
 * @since   1.3
 */
class SalesItemPricing {

    //-- Class variables ------------------------

    static constraints = {
        quantity(min: 0.0d)
        unit()
        discountPercent(scale: 2, min: 0.0d, widget: 'percent')
        adjustment(widget: 'currency')
        items(minSize: 1)
    }
    static hasMany = [items: SalesItemPricingItem]
    static mapping = {
        items cascade: 'all-delete-orphan'
    }
    static transients = [
        'discountPercentAmount', 'step1TotalPrice', 'step1UnitPrice',
        'step2Total', 'step2TotalUnitPrice', 'step3TotalPrice'
    ]


    //-- Instance variables ---------------------

    double quantity = 1.0d
    Unit unit
    double discountPercent
    double adjustment
    List<SalesItemPricingItem> items


    //-- Public methods -------------------------

    /**
     * Represents the boolean value of this sales item pricing.  The pricing is
     * {@code true} if and only if there are pricing items.
     *
     * @return  the boolean value of this pricing
     */
    boolean asBoolean() {
        return !!items
    }

    /**
     * Computes the total price for the item at the given position.
     *
     * @param pos   the given zero-based item position
     * @return      the total price of the item at the given position
     */
    double computeTotalOfItem(int pos) {
        SalesItemPricingItem item = items[pos]
        if (PricingItemType.sum == item.type) {
            return getCurrentSum(pos - 1)
        } else {
            return item.quantity * computeUnitPriceOfItem(pos)
        }
    }

    /**
     * Computes the unit price for the item at the given position.
     *
     * @param pos   the given zero-based item position
     * @return      the unit price of the item at the given position;
     *              {@code null} if the item is of type {@code SUM} which does
     *              not have a unit price
     */
    double computeUnitPriceOfItem(int pos) {
        SalesItemPricingItem item = items[pos]
        switch (item.type) {
        case PricingItemType.absolute:
            return item.unitPrice
        case PricingItemType.relativeToPos:
            return (item.relToPos == null) ? 0.0d
                : item.unitPercent * computeTotalOfItem(item.relToPos) / 100.0d
        case PricingItemType.relativeToLastSum:
            int otherPos = getLastSumPos(pos - 1)
            if (otherPos >= 0) {
                return item.unitPercent * computeTotalOfItem(otherPos) / 100.0d
            }
            // fall through
        case PricingItemType.relativeToCurrentSum:
            return item.unitPercent * getCurrentSum(pos - 1) / 100.0d
        default:
            return 0.0d
        }
    }

    /**
     * Gets the sum of all items' total prices at the given position and
     * before.
     *
     * @param pos   the given zero-based position
     * @return      the current sum
     */
    double getCurrentSum(int pos = items.size() - 1) {
        double sum = 0.0d
        for (int i = pos; i >= 0; --i) {
            if (items[i] && PricingItemType.sum != items[i].type) {
                sum += computeTotalOfItem(i)
            }
        }
        return sum
    }

    /**
     * Gets the amount of discount for this sales item in step 2.
     *
     * @return  the discount amount
     */
    double getDiscountPercentAmount() {
        return step1TotalPrice * discountPercent / 100.0d
    }

    /**
     * Gets the last position of the item of type {@code SUM}.
     *
     * @param pos   the given zero-based position
     * @return      the zero-based position of the last subtotal sum; -1 if no
     *              such an item exists
     */
    int getLastSumPos(int start = items.size() - 1) {
        for (int i = start; i >= 0; --i) {
            if (items[i] && PricingItemType.sum == items[i].type) {
                return i
            }
        }

        return -1
    }

    /**
     * Gets the total price of this sales item in step 1 as sum of all pricing
     * items.
     *
     * @return  the total price of the sales item in step 1
     */
    double getStep1TotalPrice() {
        return getCurrentSum()
    }

    /**
     * Gets the unit price of this sales item in step 1 as ratio between the
     * sum of all pricing items and the quantity.
     *
     * @return  the unit price of the sales item in step 1; {@code null} if
     *          quantity is zero
     */
    Double getStep1UnitPrice() {
        return (quantity == 0.0d) ? null : step1TotalPrice / quantity
    }

    /**
     * Gets the total of this sales item in step 2 which is the total price of
     * step 1 minus discount plus adjustment.
     *
     * @return  the total of the sales item in step 2
     */
    double getStep2Total() {
        return step1TotalPrice - discountPercentAmount + (adjustment ?: 0.0d)
    }

    /**
     * Gets the total unit price of this sales item in step 2 as ratio between
     * the total of step 2 and the quantity.
     *
     * @return  the total unit price of the sales item in step 2; {@code null}
     *          if quantity is zero
     */
    Double getStep2TotalUnitPrice() {
        return (quantity == 0.0d) ? null : step2Total / quantity
    }

    /**
     * Gets the total price of this sales item in step 3 which is the same as
     * the total of step 2.
     *
     * @return  the total price of the sales item in step 3
     */
    double getStep3TotalPrice() {
        return step2Total
    }

    @Override
    public boolean equals(Object obj) {
        if (obj instanceof SalesItemPricing) {
            return obj.id == id
        } else {
            return false
        }
    }

    @Override
    public int hashCode() {
        return id as int
    }

    @Override
    String toString() {
        return "Sales item pricing ${id}"
    }
}
