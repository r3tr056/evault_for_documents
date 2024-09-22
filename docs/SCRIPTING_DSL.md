# Scooper DSL(Domain Specific Language) for Automation Scripting

1. **Extensibility**: The DSL should allow easy addition of new types of events and operations.
2. **Modularity**: We should allow reuse of defined views, operations, and states.
3. **Error Handling**: It should handle various conditions, such as retries, errors, or dynamic elements.
4. **Variables**: It should allow parameterization of operations to make scripts reusable.
5. **Async Operations**: Support for asynchronous or conditional actions (like waiting for an element to appear).
6. **Metadata and Comments**: Optional support for metadata and comments to document the scripts.

### Proposed DSL Structure

We can organize the DSL into the following sections:
1. **Views**: Define the UI elements (views) on the screen.
2. **States**: Define what a valid screen state looks like based on the views.
3. **Variables**: Parameterization for reusability of text, keys, coordinates, etc.
4. **Conditions**: Define conditional logic, such as waiting for elements to appear.
5. **Operations**: Define a series of actions to be performed.
6. **Main Flow**: The main workflow of the operations tied to the states.

## DSL Example 1

```json
{
    "metadata": {
        "description": "Script to automate login process in an Android app",
        "author": "retro56",
        "version": "1.0",
        "date_created": "2024-09-17"
    },
    "views": {
        "login_email": {
            "resource_id": ".*email",
            "class": ".*EditText",
            "timeout": 5000  # Optional: Wait for 5 seconds before deciding the view is not present
        },
        "login_password": {
            "resource_id": ".*password",
            "class": ".*EditText"
        },
        "login_button": {
            "resource_id": ".*next",
            "class": ".*Button",
            "retry": 3  # Optional: Retry finding this element 3 times
        },
        "error_message": {
            "resource_id": ".*error_message",
            "class": ".*TextView",
            "optional": true  # Optional: View may or may not be present
        }
    },
    "states": {
        "login_state": {
            "views": ["login_email", "login_password", "login_button"],
            "conditions": [
                {
                    "view": "error_message",
                    "on_present": {
                        "action": "log", 
                        "message": "Error message found! Login might have failed."
                    }
                }
            ]
        }
    },
    "variables": {
        "user_email": "sample@email.com",
        "user_password": "sample_password"
    },
    "operations": {
        "login_operation": [
            {
                "event_type": "set_text",
                "target_view": "login_email",
                "text": "{{user_email}}"  # Using variable for email
            },
            {
                "event_type": "set_text",
                "target_view": "login_password",
                "text": "{{user_password}}"  # Using variable for password
            },
            {
                "event_type": "touch",
                "target_view": "login_button",
                "delay": 1000  # Optional: Wait 1 second before touching the button
            },
            {
                "event_type": "wait_for",
                "target_view": "error_message",
                "timeout": 5000,  # Wait for 5 seconds to see if error message appears
                "on_timeout": {
                    "action": "log",
                    "message": "No error found, assuming login success"
                },
                "on_present": {
                    "action": "exit"
                }
            },
            {
                "event_type": "exit"  # Exit the automation script
            }
        ]
    },
    "error_handling": {
        "retry_strategy": {
            "max_retries": 3,
            "delay_between_retries": 2000
        },
        "fallback": {
            "action": "log",
            "message": "Operation failed after retries"
        }
    },
    "main": {
        "login_state": ["login_operation"]
    }
}
```

## Example 2 : DSL with Conditional Control
```json
{
    "metadata": {
        "description": "Script to automate login process with conditional operations",
        "author": "retro56",
        "version": "1.1",
        "date_created": "2024-09-17"
    },
    "views": {
        "login_email": {
            "resource_id": ".*email",
            "class": ".*EditText"
        },
        "login_password": {
            "resource_id": ".*password",
            "class": ".*EditText"
        },
        "login_button": {
            "resource_id": ".*next",
            "class": ".*Button"
        },
        "error_message": {
            "resource_id": ".*error_message",
            "class": ".*TextView"
        },
        "welcome_message": {
            "resource_id": ".*welcome",
            "class": ".*TextView",
            "optional": true
        }
    },
    "states": {
        "login_state": {
            "views": ["login_email", "login_password", "login_button"]
        },
        "logged_in_state": {
            "views": ["welcome_message"]
        }
    },
    "variables": {
        "user_email": "sample@email.com",
        "user_password": "sample_password"
    },
    "operations": {
        "login_operation": [
            {
                "event_type": "set_text",
                "target_view": "login_email",
                "text": "{{user_email}}"
            },
            {
                "event_type": "set_text",
                "target_view": "login_password",
                "text": "{{user_password}}"
            },
            {
                "event_type": "touch",
                "target_view": "login_button"
            },
            {
                "event_type": "wait_for",
                "target_view": "error_message",
                "timeout": 5000,
                "on_present": {
                    "action": "log",
                    "message": "Error during login. Exiting..."
                },
                "on_timeout": {
                    "action": "check_state",
                    "state": "logged_in_state"
                }
            }
        ],
        "post_login_operation": [
            {
                "event_type": "if",
                "condition": {
                    "view_present": "welcome_message"
                },
                "then": [
                    {
                        "event_type": "log",
                        "message": "Login successful, welcome message found."
                    }
                ],
                "else": [
                    {
                        "event_type": "log",
                        "message": "Login failed, welcome message not found."
                    },
                    {
                        "event_type": "exit"
                    }
                ]
            }
        ]
    },
    "error_handling": {
        "retry_strategy": {
            "max_retries": 3,
            "delay_between_retries": 2000
        }
    },
    "main": {
        "login_state": ["login_operation", "post_login_operation"]
    }
}

```

### Key Improvements and Features:

1. **Metadata Section**: The script includes metadata for documentation and versioning.
2. **Timeouts and Retries**: Added options for specifying timeouts and retry mechanisms for views.
3. **Conditions**: The DSL allows you to define conditions to handle dynamic elements (e.g., error messages).
4. **Variables**: The DSL supports variables for parameterizing input, making it more reusable.
5. **Delay**: Option to add a delay between operations, making the script more flexible for slower devices or apps.
6. **Error Handling**: There’s a built-in error handling mechanism that can retry operations and log errors.
7. **Conditional Actions**: You can specify conditional actions, such as logging a message if an error view appears.
8. **Async/Wait Operations**: The `wait_for` event type waits for a view to appear or disappear with optional timeouts and actions based on the outcome.
9. **Modular States**: States and operations are modular, making them reusable across multiple screens or tasks.

### Example Usage of Variables and Conditions:

```json
{
    "event_type": "set_text",
    "target_view": "login_email",
    "text": "{{user_email}}"  # Using a variable for email
}
```

This allows you to reuse the script with different inputs by changing the variables section.

### Additional Event Types:

- **set_text**: Sets text in a view.
- **touch**: Simulates a touch event on a view.
- **wait_for**: Waits for a view to appear or disappear.
- **swipe**: Performs a swipe gesture.
- **scroll**: Scrolls the view.
- **exit**: Exits the script.
- **log**: Logs a message (for debugging or monitoring).
- **intent**: Triggers an Android intent.
- **retry**: Retry a specific operation with parameters for delay and count.

### Execution Flow:
- The `main` section ties the states and operations together.
- The operations can be executed conditionally based on the presence of certain views or states.

### Asynchronous Operations:
You can extend the DSL to handle asynchronous flows, like waiting for a network response or handling delays dynamically. This is supported by the `wait_for` event type in the example.

### Extensibility:
You can easily add new events (like double tap, long press, etc.) and actions in the operations by updating the DSL.