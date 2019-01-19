({
    init: function (component) {

        const contextComponent = component.get('v.context');
        const utilsProps = {
            _component: {
                writable: false,
                configurable: false,
                enumerable: false,
                value: contextComponent,
            },
        };

        const utils = Object.create(this.getUtils(), utilsProps);

        const componentProps = {
            writable: false,
            configurable: false,
            enumerable: false,
            value: utils,
        };
        Object.defineProperty(contextComponent, 'utils', componentProps);
    },

    getUtils: function () {
        if (!this._utils) {
            this._utils = this.createUtils();
        }

        return this._utils;
    },

    createUtils: function () {

        return {
            callApex: this.callApex,
            check: function () {
                console.log('CHECK!!!')
            },
            showToast: this.showToast
        }

    },


    callApex: function (action, params, success, fail) {

        if (!action) {
            throw 'No Action'
        }

        action.setParams(params)

        action.setCallback(this, function (a) {
            if (a.getState() === "SUCCESS") {
                $A.log("Success", a.getReturnValue())
                if (success) {
                    success.apply(this, [a.getReturnValue()])
                }
            } else if (a.getState() === "ERROR") {
                $A.log("Errors", a.getError())
                if (fail) {
                    fail.apply(this, [a.getError()])
                } else {
                    var error = a.getError()
                    console.error('callApex error', error)
                    if (error && error.length) {
                        alert(error[0].message)
                    } else {
                        throw error
                    }
                }
            }
        });

        $A.enqueueAction(action)

    },

    showToast: function (params) {
        var toastEvent = $A.get("e.force:showToast");
        if (toastEvent) {
            toastEvent.setParams(params);
            toastEvent.fire();
        } else {
            throw 'No Toast'
        }
    }
})