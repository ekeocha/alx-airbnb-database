Here’s your **Markdown file** that documents the **normalization process** for the AirBnB database — from the raw specification to a fully **Third Normal Form (3NF)** schema.

You can copy and save this as `AirBnB_Normalization.md`.

---

# 🏠 AirBnB Database Normalization (to 3NF)

## 📘 Overview

This document describes the process of normalizing the **AirBnB database** to ensure it satisfies the **Third Normal Form (3NF)**.
Normalization removes redundancy, ensures data integrity, and makes the schema efficient for updates and queries.

---

## ⚙️ Step 1: Identify the Entities and Attributes

### Entities Identified

1. **User**
2. **Property**
3. **Booking**
4. **Payment**
5. **Review**
6. **Message**

Each entity contains atomic attributes — no repeating groups.

---

## 🧩 Step 2: First Normal Form (1NF)

### 1NF Rule

* Each attribute contains **atomic values**.
* Each record is **unique** and identifiable by a **primary key**.

### Application

✅ All attributes (e.g., `first_name`, `email`, `pricepernight`, `start_date`) hold a single value.
✅ Each table has a **primary key** (`user_id`, `property_id`, etc.).
✅ No repeating or multivalued fields exist.

✅ **Result:** The schema is in **1NF**.

---

## 🔗 Step 3: Second Normal Form (2NF)

### 2NF Rule

* The database must be in 1NF.
* There should be **no partial dependencies** (non-key attributes must depend on the entire primary key).

### Application

* All tables use **single-attribute primary keys** (UUIDs).
* No table uses a composite key.
* Therefore, all non-key attributes depend entirely on their respective primary key.

✅ **Result:** The schema is in **2NF**.

---

## 🧠 Step 4: Third Normal Form (3NF)

### 3NF Rule

* The database must be in 2NF.
* There should be **no transitive dependencies** — non-key attributes cannot depend on other non-key attributes.

### Review of Each Entity

#### **1. User**

| Attribute                                                                   | Depends On                        | Note                       |
| --------------------------------------------------------------------------- | --------------------------------- | -------------------------- |
| first_name, last_name, email, password_hash, phone_number, role, created_at | user_id                           | All depend on the PK only. |
| ✅                                                                           | No transitive dependencies found. |                            |

#### **2. Property**

| Attribute                                              | Depends On                  | Note                      |
| ------------------------------------------------------ | --------------------------- | ------------------------- |
| host_id                                                | user_id (FK)                | External dependency only. |
| name, description, location, pricepernight, timestamps | property_id                 | Depend directly on PK.    |
| ✅                                                      | No transitive dependencies. |                           |

#### **3. Booking**

| Attribute                                             | Depends On                  | Note                         |
| ----------------------------------------------------- | --------------------------- | ---------------------------- |
| property_id, user_id                                  | FKs                         | Referential, not transitive. |
| start_date, end_date, total_price, status, created_at | booking_id                  | Depend directly on PK.       |
| ✅                                                     | No transitive dependencies. |                              |

#### **4. Payment**

| Attribute                            | Depends On                  | Note                      |
| ------------------------------------ | --------------------------- | ------------------------- |
| booking_id                           | FK                          | External, not transitive. |
| amount, payment_date, payment_method | payment_id                  | Depend directly on PK.    |
| ✅                                    | No transitive dependencies. |                           |

#### **5. Review**

| Attribute                   | Depends On                  | Note                   |
| --------------------------- | --------------------------- | ---------------------- |
| property_id, user_id        | FKs                         | External.              |
| rating, comment, created_at | review_id                   | Depend directly on PK. |
| ✅                           | No transitive dependencies. |                        |

#### **6. Message**

| Attribute               | Depends On                  | Note                   |
| ----------------------- | --------------------------- | ---------------------- |
| sender_id, recipient_id | FKs                         | External.              |
| message_body, sent_at   | message_id                  | Depend directly on PK. |
| ✅                       | No transitive dependencies. |                        |

---

## 🧾 Step 5: Final 3NF Schema

### **User**

```
user_id (PK)
first_name
last_name
email (UNIQUE)
password_hash
phone_number
role (ENUM: guest, host, admin)
created_at
```

### **Property**

```
property_id (PK)
host_id (FK → User.user_id)
name
description
location
pricepernight
created_at
updated_at
```

### **Booking**

```
booking_id (PK)
property_id (FK → Property.property_id)
user_id (FK → User.user_id)
start_date
end_date
total_price
status (ENUM: pending, confirmed, canceled)
created_at
```

### **Payment**

```
payment_id (PK)
booking_id (FK → Booking.booking_id)
amount
payment_date
payment_method (ENUM: credit_card, paypal, stripe)
```

### **Review**

```
review_id (PK)
property_id (FK → Property.property_id)
user_id (FK → User.user_id)
rating (1–5)
comment
created_at
```

### **Message**

```
message_id (PK)
sender_id (FK → User.user_id)
recipient_id (FK → User.user_id)
message_body
sent_at
```

---

## 🧱 Step 6: Verification Summary

| Normal Form | Requirements               | Met? | Remarks                                   |
| ----------- | -------------------------- | ---- | ----------------------------------------- |
| **1NF**     | Atomic attributes          | ✅    | No repeating groups                       |
| **2NF**     | No partial dependencies    | ✅    | All PKs are single attributes             |
| **3NF**     | No transitive dependencies | ✅    | All non-key attributes depend only on PKs |

---

## ✅ **Conclusion**

The **AirBnB database** design satisfies all the requirements for **Third Normal Form (3NF)**:

* Eliminated redundancy
* Ensured data integrity through foreign keys
* Preserved meaningful relationships between entities
* Optimized structure for queries, updates, and scalability

This schema is ready for implementation in a relational database like **PostgreSQL** or **MySQL**.

