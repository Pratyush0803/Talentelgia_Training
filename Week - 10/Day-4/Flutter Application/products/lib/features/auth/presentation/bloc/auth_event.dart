abstract class AuthEvent{}

class LoginRequested extends AuthEvent{
final String email, password;
LoginRequested(this.email, this.password);
}