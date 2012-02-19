import oursql 

# My exception class 
class ProgrammingError(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)

# DBHelper class 
class DBHelper(object): 
   
    # Initial values .
    def __init__(self,username,password,url,database='employees',pt=3306):
        self.conn = oursql.connect(host=url, user=username, passwd=password,
                    db=database,port=pt)
        self.curs = self.conn.cursor(oursql.DictCursor)
        self.curs = self.conn.cursor(try_plain_query=False)
        self.curs.arraysize=2

    # update the database .
    def update(self,sqlquery,parameters=()):
        try :
            if sqlquery.lower().startswith('update'):
                self.curs.execute(sqlquery,parameters)
                return self.curs.rowcount
            else : 
                print "Not an update statement"
                raise ProgrammingError("Update : Not a update statement")
        except oursql.ProgrammingError:
            print "Programming Error : Check Parameters passed"
        except oursql.IntegrityError as (a,b,c) :
            print "IntegrityError : " + str((a,b,c))
         
    # insert value .
    def insert(self,sqlquery,parameters=()):
        try :
            if sqlquery.lower().startswith('insert') :
                self.curs.execute(sqlquery,parameters)
                return self.curs.lastrowid
            else : 
                print "Not an insert statement"
                raise ProgrammingError("Insert : Not an insert statement")
        except oursql.ProgrammingError:
            print "Programming Error : Check Parameters passed"
            raise 
        except oursql.IntegrityError as (a,b,c) :
            print "IntegrityError : " + str((a,b,c))
            raise 

    # Perform the given query and returns a string or an integer
    def query(self,sqlquery,parameters=()):
        try :
            if sqlquery.lower().startswith('select'):
                self.curs.execute(sqlquery,parameters)
                out = self.curs.fetchall()
                if len(out) > 1 or len(out)==0:
                    raise ProgrammingError("query : More than one match or 0 match") 
                else:
                    fout = out[0]
                    if len(fout)>1 or len(fout)==0:
                        raise ProgrammingError("query : Can request for a single attribute only") 
                    else:
                        return fout[0]
            else : 
                print "Not an query statement"
                raise ProgrammingError("Query: Not a select statement")
        except oursql.ProgrammingError:
            print "Programming Error : Check Parameters passed"
            raise 
    
if __name__ == "__main__":
    employees = DBHelper('root','satvik99','localhost')
    #print employees.update("update salaries set salary = salary+0")
    #print employees.insert('insert into departments values(?,?)',('d117','python check 117'))
    #employees.queryForString('select row_count()')
    #for a in employees.curs:
        #print a
    print employees.query("select d.dept_no from departments d where d.dept_no='d111'")
    print employees.query('select d.birth_date from employees d where d.emp_no=?',(210472,))
    print employees.query('select * from employees d',())

