# Discipline Alarm

> **A behavior-enforcing alarm designed to make waking up an action, not a decision.**

---

## 1. Project Vision

Discipline Alarm is an alarm and reminder application focused on helping users **actually act on their intentions**.

A traditional alarm asks:

> "Do you want to wake up?"

Discipline Alarm should eventually say:

> **"You set the goal. Now complete it."**

The long-term idea is to combine alarms, physical movement, challenges, streaks, and accountability into a system that makes it difficult to simply dismiss an alarm and go back to sleep.

However, this project will **not attempt to build the complete vision immediately**.

The development will happen through multiple MVP stages.

---

# 2. Development Philosophy

The project will follow three major stages:

```text
                    DISCIPLINE ALARM
                          │
                          ▼
                ┌───────────────────┐
                │      MVP 1        │
                │ Foundation        │
                │ "Does it work?"   │
                └─────────┬─────────┘
                          │
                          ▼
                ┌───────────────────┐
                │      MVP 2        │
                │ Enforcement       │
                │ "Does it wake me?"│
                └─────────┬─────────┘
                          │
                          ▼
                ┌───────────────────┐
                │      MVP 3        │
                │ Discipline        │
                │ "Can I cheat?"    │
                └───────────────────┘
```

### MVP 1

Build a reliable, polished alarm/reminder application and learn the fundamentals of production Flutter + Android development.

### MVP 2

Turn the ordinary alarm into a **behavior-enforcing alarm**.

### MVP 3

Make the system progressively harder to ignore, bypass, or cheat while keeping the experience practical for a normal Android user.

---

# 3. Why Build MVP 1?

The first version is intentionally not revolutionary.

There are already thousands of alarm and reminder applications.

That is okay.

The purpose of MVP 1 is primarily:

* Learn.
* Build.
* Test.
* Understand Android.
* Establish a clean codebase.
* Ship something real.
* Publish the first version on Google Play.

MVP 1 should prove that I can take an idea from:

```text
Idea
 ↓
UI Design
 ↓
Architecture
 ↓
Implementation
 ↓
Android Integration
 ↓
Testing
 ↓
Release Build
 ↓
Google Play
```

The goal is not to immediately create the final product.

The goal is to create a **strong foundation for the final product**.

---

# 4. MVP 1: Foundation

## 🎯 Main Objective

Build a functional alarm + reminder application with a polished UI, reliable local functionality, proper Android permissions, and a clean Flutter architecture.

### MVP 1 should answer:

> **Can the application reliably schedule and trigger an alarm even when the application is not actively open?**

If the answer is yes, MVP 1 is moving in the right direction.

---

# 5. MVP 1 Scope

## 5.1 UI

### Home

* [ ] Today's alarms
* [ ] Active/inactive alarm states
* [ ] Quick overview
* [ ] Basic statistics
* [ ] Navigation structure

### Alarm

* [ ] Alarm list
* [ ] Create alarm
* [ ] Edit alarm
* [ ] Delete alarm
* [ ] Enable/disable alarm
* [ ] Time picker
* [ ] Repeat options

### Alarm Ring Screen

* [ ] Full-screen alarm experience
* [ ] Large time display
* [ ] Alarm label
* [ ] Sound
* [ ] Stop/dismiss action
* [ ] Proper visual hierarchy
* [ ] Transition into and out of ringing state

### Reminder

Reminders should remain conceptually separate from alarms.

```text
ALARM
"You must respond now."

REMINDER
"Don't forget this later."
```

This separation should remain visible in the application structure so users don't confuse the two.

### Settings

* [ ] Sound settings
* [ ] Default alarm configuration
* [ ] Basic app preferences
* [ ] Permission status where useful

---

# 6. MVP 1 Core Functionality

## Alarm Creation

User should be able to:

* [ ] Select time
* [ ] Set label
* [ ] Select repeat pattern
* [ ] Save alarm
* [ ] Edit alarm
* [ ] Delete alarm
* [ ] Enable/disable alarm

### Repeat options

Initially:

* [ ] Once
* [ ] Daily
* [ ] Weekdays
* [ ] Custom days

---

# 7. Android Integration

This is one of the most important parts of MVP 1.

The application should not only *look* like an alarm application.

It should actually behave like one.

### Permissions / System Integration

Investigate and implement the permissions required for the target Android versions, including where applicable:

* [ ] Notification permission
* [ ] Exact alarm capability/permission
* [ ] Full-screen intent capability
* [ ] Audio-related requirements
* [ ] Foreground service requirements
* [ ] Battery optimization considerations

The exact implementation should follow the Android version and APIs supported by the application.

---

# 8. Alarm Lifecycle

The basic lifecycle should look like:

```text
User creates alarm
       │
       ▼
Alarm saved locally
       │
       ▼
Alarm scheduled with Android
       │
       ▼
Application closed
       │
       ▼
Phone locked
       │
       ▼
Scheduled time arrives
       │
       ▼
Alarm is triggered
       │
       ▼
Ringing UI appears
       │
       ▼
User completes MVP 1 dismiss action
       │
       ▼
Alarm stops
       │
       ▼
Result is recorded
```

The important part is everything between **"Application closed"** and **"Ringing UI appears."**

That is where much of the real Android learning will happen.

---

# 9. Technical Learning Goals

MVP 1 should deliberately be used as a learning project.

## Flutter

* [ ] Widget architecture
* [ ] Reusable components
* [ ] Navigation
* [ ] State management
* [ ] Form handling
* [ ] Responsive UI
* [ ] Animation basics
* [ ] Error/loading/empty states

## Dart

* [ ] Models
* [ ] Enums
* [ ] Async programming
* [ ] Futures
* [ ] Streams where required
* [ ] Exception handling
* [ ] Clean abstractions

## State Management

Use one consistent approach.

Preferred:

> **Riverpod**

Avoid mixing multiple state-management approaches without a specific reason.

---

# 10. Project Architecture

The project should avoid putting everything inside screens.

A possible structure:

```text
lib/
│
├── core/
│   ├── constants/
│   ├── theme/
│   ├── utils/
│   └── errors/
│
├── features/
│   │
│   ├── alarm/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── reminder/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── statistics/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── services/
│   ├── notification_service/
│   ├── alarm_service/
│   └── storage_service/
│
└── main.dart
```

This does not have to be followed religiously.

The principle is more important:

> **UI should not contain the entire application's business logic.**

---

# 11. Local Data

MVP 1 does not need a backend.

Keep it local.

Possible storage:

* SharedPreferences for simple settings
* Hive or another local database for structured application data

Potential entities:

```text
Alarm
 ├── id
 ├── time
 ├── label
 ├── repeatDays
 ├── enabled
 └── configuration

Reminder
 ├── id
 ├── title
 ├── date/time
 ├── completed
 └── configuration

AppSettings
 ├── sound
 ├── vibration
 └── preferences
```

No authentication.

No cloud database.

No unnecessary backend.

---

# 12. MVP 1 Testing Strategy

The application should be tested in conditions that resemble real usage.

### Basic testing

* [ ] Create alarm
* [ ] Edit alarm
* [ ] Delete alarm
* [ ] Enable/disable alarm
* [ ] Repeat alarm
* [ ] Multiple alarms
* [ ] Reminder creation
* [ ] Reminder completion

### Real-device testing

* [ ] App open
* [ ] App in background
* [ ] App completely closed
* [ ] Phone locked
* [ ] Phone restarted
* [ ] Permission denied
* [ ] Notification permission disabled
* [ ] Battery optimization enabled
* [ ] Multiple alarms scheduled

### Edge cases

* [ ] Alarm scheduled a few minutes ahead
* [ ] Alarm scheduled for next day
* [ ] Repeating alarm
* [ ] Two alarms close together
* [ ] Alarm edited after scheduling
* [ ] Alarm deleted after scheduling
* [ ] Device rebooted before alarm

---

# 13. MVP 1 Definition of Done

MVP 1 is **NOT** complete because every screen exists.

It is complete when the following are true:

* [ ] Core UI is implemented
* [ ] Navigation works
* [ ] Alarm creation works
* [ ] Alarm editing works
* [ ] Alarm deletion works
* [ ] Repeat schedules work
* [ ] Local persistence works
* [ ] Required permissions are handled
* [ ] Alarm is scheduled correctly
* [ ] Alarm triggers correctly
* [ ] Ringing screen works
* [ ] Alarm works with app closed
* [ ] Alarm works with phone locked
* [ ] Major edge cases are tested
* [ ] Release build works
* [ ] Application has been tested on a physical device
* [ ] MVP documentation is updated
* [ ] Version is ready for Google Play submission

### Final MVP 1 milestone

> **Ship it.**

Not:

> "I'll publish it once I polish this one tiny animation."

---

# 14. Weekend Development Plan

Since development time is primarily available on weekends, the timeline should be based on **deliverable milestones**, not unrealistic daily targets.

## Weekend 1: Foundation

* [ ] Finalize basic UI structure
* [ ] Set up project architecture
* [ ] Set up theme
* [ ] Set up navigation
* [ ] Set up state management
* [ ] Create basic models
* [ ] Create local storage abstraction

**Deliverable:**

> Application skeleton with working navigation and architecture.

---

## Weekend 2: Alarm Creation

* [ ] Alarm model
* [ ] Create alarm screen
* [ ] Edit alarm
* [ ] Delete alarm
* [ ] Enable/disable
* [ ] Repeat configuration
* [ ] Local persistence

**Deliverable:**

> User can create and manage alarms locally.

---

## Weekend 3: Real Alarm

* [ ] Android alarm scheduling
* [ ] Notification setup
* [ ] Required permissions
* [ ] Alarm sound
* [ ] Full-screen alarm UI
* [ ] Stop/dismiss flow

**Deliverable:**

> A real alarm fires at the scheduled time.

---

## Weekend 4: Reliability

* [ ] App-closed testing
* [ ] Locked-device testing
* [ ] Reboot handling
* [ ] Multiple alarms
* [ ] Permission edge cases
* [ ] Battery optimization investigation
* [ ] Bug fixing

**Deliverable:**

> Alarm behavior is reliable enough for real-world testing.

---

## Weekend 5: Reminder + Polish

* [ ] Reminder section
* [ ] Basic reminder functionality
* [ ] Statistics foundation
* [ ] UI polish
* [ ] Empty states
* [ ] Error states
* [ ] Loading states

**Deliverable:**

> Complete MVP 1 experience.

---

## Weekend 6: Release

No major new features.

Only:

* [ ] Testing
* [ ] Bug fixes
* [ ] Performance
* [ ] Build configuration
* [ ] App icon
* [ ] Splash screen
* [ ] Store assets
* [ ] Privacy requirements
* [ ] Release build
* [ ] Play Store preparation

**Deliverable:**

> **MVP 1 → Google Play**

---

# 15. MVP 2: Behavioral Enforcement

MVP 2 is where the application starts becoming **Discipline Alarm** rather than simply another alarm application.

## 🎯 Objective

Change the fundamental interaction from:

```text
Alarm
  ↓
Dismiss
  ↓
Go back to sleep
```

to:

```text
Alarm
  ↓
Challenge
  ↓
Physical action
  ↓
Proof of completion
  ↓
Alarm stops
```

The application is no longer simply notifying the user.

It is asking the user to **prove that they are awake**.

---

# 16. MVP 2 Challenges

## 🚶 Step Challenge

Example:

> Walk 100 steps.

Flow:

```text
Alarm rings
     ↓
Step challenge begins
     ↓
User starts walking
     ↓
Sensor detects movement
     ↓
100 steps completed
     ↓
Alarm stops
```

Possible difficulty levels:

* Easy → 30 steps
* Medium → 100 steps
* Hard → 500 steps

The exact thresholds should eventually be configurable.

---

# 17. 📷 QR Challenge

User places a QR code somewhere away from the bed.

Example:

```text
Bed
 │
 │
 ▼
Bathroom
 │
 ▼
QR Code
```

Alarm:

> **"Get up and scan your bathroom QR."**

Flow:

```text
Alarm
 ↓
QR challenge
 ↓
User physically leaves bed
 ↓
QR scanner opens
 ↓
Correct QR detected
 ↓
Alarm stops
```

This is particularly interesting because the challenge itself creates physical separation from the bed.

---

# 18. Photo Challenge

Later:

> "Take a photo of your bathroom."

This can potentially be used as another proof mechanism.

However, proper photo validation is significantly more complicated.

Therefore:

**Do not prioritize this before QR + Steps work reliably.**

---

# 19. Anti-Snooze Philosophy

MVP 2 should remove the traditional snooze concept.

Instead:

```text
                    ALARM
                      │
             ┌────────┴────────┐
             │                 │
         Challenge          Failure
             │                 │
             ▼                 ▼
         Complete          Keep going
             │                 │
             └────────┬────────┘
                      ▼
                 Alarm stops
```

The user should not be given a simple:

> "Snooze for 10 minutes"

button.

The core philosophy is:

> **The alarm ends because the user completed the task, not because the user negotiated with the alarm.**

---

# 20. Important Android Limitation

The application should **not promise impossible system-level control**.

A normal consumer Android application cannot guarantee:

> "The user can never uninstall this application."

Users can potentially:

* Force-stop the application
* Disable permissions
* Change system settings
* Reboot the device
* Uninstall the application
* Restrict background activity

Therefore the goal should be:

> **Make the intended behavior difficult to bypass, rather than pretending the app can control the entire operating system.**

Device-admin or kiosk-style mechanisms are a completely different category and should not become part of the normal MVP.

---

# 21. MVP 3: Discipline System

MVP 3 is where the application evolves from a challenge-based alarm into a broader behavior system.

## 🎯 Objective

Create a system where users gradually build discipline rather than simply completing isolated alarms.

Potential features:

### 🔥 Streaks

* [ ] Current streak
* [ ] Best streak
* [ ] Daily success
* [ ] Failure tracking
* [ ] Weekly performance

Example milestones:

```text
3 days   → Beginner
7 days   → Consistent
30 days  → Elite
```

---

## 🎚 Difficulty

Difficulty can evolve based on user configuration or performance.

Example:

```text
Easy
 │
 ├── 30 steps
 └── Simple challenge

Medium
 │
 ├── 100 steps
 └── QR challenge

Hard
 │
 ├── 500 steps
 ├── QR from another room
 └── Multiple actions
```

The exact mechanics should be validated through real user testing before becoming complicated.

---

# 22. Penalty System

Possible future penalties:

* [ ] Streak reset
* [ ] Failure notification
* [ ] Funny/savage message
* [ ] Increased difficulty
* [ ] Accountability mechanism

Example messages:

> "You failed. Again."

> "Your future self is disappointed."

> "The alarm won. You didn't."

The personality should remain fun rather than genuinely hostile.

---

# 23. Reminder vs Alarm

This distinction should remain fundamental.

### Alarm

An alarm represents a **time-sensitive action**.

> "Wake up at 6:00 AM."

Eventually:

> "Wake up and walk 100 steps."

### Reminder

A reminder represents **something you don't want to forget**.

> "Submit assignment at 8 PM."

Future possibility:

> "Study at 7 PM → optionally complete a small activation task."

This allows the application to evolve beyond waking up without turning every reminder into an annoying alarm.

---

# 24. Long-Term Product Direction

The eventual system could look like:

```text
                 DISCIPLINE ALARM
                        │
          ┌─────────────┴─────────────┐
          │                           │
        ALARMS                     REMINDERS
          │                           │
          ▼                           ▼
      Wake-up task                Normal reminder
          │
          ▼
      CHALLENGE
          │
    ┌─────┼─────┐
    │     │     │
  Steps  QR   Photo
    │     │     │
    └─────┼─────┘
          ▼
      Completion
          │
          ▼
       STREAK
          │
          ▼
      DISCIPLINE
```

The product should grow from an alarm application into a **behavior-enforcement system** only after the basic foundation has been proven.

---

# 25. Things Explicitly Out of Scope

To prevent feature creep, the following should **not** be part of MVP 1:

* [ ] AI
* [ ] Machine learning
* [ ] Social network
* [ ] Friends system
* [ ] Payments
* [ ] Financial penalties
* [ ] Cloud backend
* [ ] Complex authentication
* [ ] Advanced photo verification
* [ ] Complex gamification
* [ ] AI wake-up analysis

These can be considered later.

### Rule:

> **If a feature does not help prove the current MVP, postpone it.**

---

# 26. Future Ideas

Possible post-MVP features:

* Social accountability
* Friend challenges
* Stake-based penalties
* Advanced streak system
* Personalized difficulty
* Wake-up analytics
* AI-based insights
* Voice challenges
* Adaptive alarm difficulty
* Morning routines
* Habit integration
* Smart challenge selection

These are ideas, **not commitments**.

---

# 27. Product Development Loop

After MVP 1, development should no longer be:

```text
Idea → Feature → Feature → Feature
```

Instead:

```text
                  ┌───────────────┐
                  │     Build     │
                  └───────┬───────┘
                          ↓
                  ┌───────────────┐
                  │    Release    │
                  └───────┬───────┘
                          ↓
                  ┌───────────────┐
                  │    Observe    │
                  └───────┬───────┘
                          ↓
                  ┌───────────────┐
                  │    Improve    │
                  └───────┬───────┘
                          ↓
                       Repeat
```

This is particularly important after MVP 2.

If users don't actually want to walk 500 steps at 6 AM, there is no reason to spend three weekends polishing a 500-step challenge.

---

# 28. Definition of Success

## MVP 1 Success

> I can build and release a functioning alarm/reminder application.

## MVP 2 Success

> I can make the alarm require a physical action before it stops.

## MVP 3 Success

> I can create a system that encourages users to consistently complete their intended actions.

## Product Success

> Users may complain about waking up, but they keep the application because **it actually helps them get up.**

---

# 29. Development Rules

### Rule 1

**Build the smallest working version first.**

### Rule 2

**Do not add a feature simply because it sounds cool.**

### Rule 3

**Prefer working functionality over theoretical architecture.**

### Rule 4

**Test on a real Android device.**

### Rule 5

**Every MVP should end with something usable.**

### Rule 6

**Don't move to the next MVP until the previous one is stable enough.**

### Rule 7

**Document problems, not just successes.**

### Rule 8

**Keep the codebase clean enough that future features don't require rebuilding everything.**

---

# 30. GitHub Development Log

Each major milestone should record:

### What I built

What functionality was added?

### What I learned

What Android/Flutter concept did I understand?

### What broke

What unexpected problem occurred?

### How I fixed it

What approach solved it?

### What I would change

If rebuilding the feature, what would I do differently?

Example:

```text
Weekend 3

Built:
- Android alarm scheduling
- Notification handling
- Ringing screen

Problem:
Alarm worked while the app was open but failed
under certain background conditions.

Learned:
Android background execution and exact alarm behavior.

Solution:
Refactored scheduling into a dedicated alarm service
and tested it on a physical device.

Next:
Test reboot + battery optimization scenarios.
```

This development history can eventually become one of the strongest parts of the repository.

---

# 31. Master Roadmap

```text
                    DISCIPLINE ALARM
                           │
                           ▼
                ┌─────────────────────┐
                │      MVP 1          │
                │                     │
                │ UI + Architecture  │
                │ Alarm + Reminder    │
                │ Permissions         │
                │ Android Integration │
                │ Testing             │
                │ Play Store         │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │      MVP 2          │
                │                     │
                │ Step Challenge      │
                │ QR Challenge        │
                │ Anti-Snooze         │
                │ Proof of Wake-up    │
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │      MVP 3          │
                │                     │
                │ Streaks             │
                │ Difficulty          │
                │ Penalties           │
                │ Stronger Enforcement│
                └──────────┬──────────┘
                           │
                           ▼
                ┌─────────────────────┐
                │   PRODUCT ITERATION │
                │                     │
                │ Users → Feedback    │
                │ → Improvements      │
                │ → New Experiments   │
                └─────────────────────┘
```

---

# 32. Final Principle

The project should not be judged by how many features it contains.

It should be judged by how many **real engineering problems have been solved**.

MVP 1 teaches:

> **How do I build and ship a real mobile application?**

MVP 2 teaches:

> **How do I interact with sensors, Android services, and real-world behavior?**

MVP 3 teaches:

> **How do I design a system around human behavior rather than just screens and buttons?**

And eventually:

> **Can I turn a small idea into a product that real people actually use?**

That is the real project.

The application is only the vehicle.
