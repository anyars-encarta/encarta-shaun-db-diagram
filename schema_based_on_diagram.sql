CREATE TABLE patients (
	id SERIAL PRIMARY KEY,
	name 	VARCHAR,
	date_of_birth DATE
)

CREATE TABLE medical_histories (
	id SERIAL PRIMARY KEY,
	admitted_at TIMESTAMP,
	patient_id INTEGER REFERENCES patients(id),
	status VARCHAR
)

CREATE INDEX ON medical_histories (patient_id);

CREATE TABLE invoices (
	id SERIAL PRIMARY KEY,
	total_amount DECIMAL(8, 2),
	generated_at TIMESTAMP,
	payed_at TIMESTAMP,
	medical_history_id INTEGER REFERENCES medical_histories(id)
)

CREATE INDEX ON invoices (medical_history_id);

CREATE TABLE invoice_items (
	id SERIAL PRIMARY KEY,
	unit_price DECIMAL(8,2),
	quantity INTEGER,
	total_price DECIMAL(8,2),
	invoice_id INTEGER REFERENCES invoices(id),
	treatment_id INTEGER REFERENCES treatments(id)
)

CREATE INDEX ON invoice_items (invoice_id, treatment_id);

CREATE TABLE treatments (
	id SERIAL PRIMARY KEY,
	type VARCHAR(255),
	name VARCHAR(255)
)

CREATE TABLE medical_history_treatment (
    medical_id INT,
	CONSTRAINT fk_medicals FOREIGN KEY(medical_id) REFERENCES medical_histories(id)
	ON DELETE CASCADE,
	
    treatment_id INT,
	CONSTRAINT fk_treatments FOREIGN KEY(treatment_id) REFERENCES treatments(id)
	ON DELETE CASCADE,
	PRIMARY KEY (medical_id, treatment_id)
);

CREATE INDEX ON medical_history_treatment (medical_id, treatment_id);