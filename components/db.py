from faker import Faker

fake = Faker()

def get_table_schema(cursor, table_name):
    cursor.execute(f"SELECT column_name, data_type FROM information_schema.columns WHERE table_name = '{table_name}'")
    return cursor.fetchall()

def generate_fake_data(schema, num_records):
    records = []
    for _ in range(num_records):
        data = {}
        for column, data_type in schema:
            if 'name' in column:
                data[column] = fake.name()
            elif 'email' in column:
                data[column] = fake.email()
            elif 'address' in column:
                data[column] = fake.address()
            elif 'phone' in column or 'mobile' in column:
                data[column] = fake.phone_number()
            elif data_type == 'integer':
                data[column] = fake.random_int()
            elif data_type == 'varchar' or data_type == 'text':
                data[column] = fake.word()
            elif data_type == 'date':
                data[column] = fake.date()
            elif data_type == 'timestamp':
                data[column] = fake.date_time()
            # Add more mappings as needed
            else:
                data[column] = None
        records.append(data)
    return records

