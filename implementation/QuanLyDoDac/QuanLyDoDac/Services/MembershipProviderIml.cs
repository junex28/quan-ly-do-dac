using System;
using System.Collections.Specialized;
using System.Configuration;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web.Configuration;
using System.Web.Security;
using QuanLyDoDac.Models;
using System.IO;

namespace QuanLyDoDac.Services
{
    public class MembershipProviderIml : MembershipProvider
    {
        #region Attributes
        private string applicationName;
        private bool enablePasswordReset;
        private bool enablePasswordRetrieval;
        private bool requiresQuestionAndAnswer;
        private bool requiresUniqueEmail;
        private int maxInvalidPasswordAttempts;
        private int passwordAttemptWindow;
        private int minRequiredPasswordLength;
        private int minRequiredNonalphanumericCharacters;
        private string passwordStrengthRegularExpression;
        private MembershipPasswordFormat passwordFormat;
        private MachineKeySection machineKey;
        #endregion

        #region Properties
        public override string ApplicationName
        {
            get { return applicationName; }
            set { applicationName = value; }
        }

        public override bool EnablePasswordReset
        {
            get { return enablePasswordReset; }
        }

        public override bool EnablePasswordRetrieval
        {
            get { return enablePasswordRetrieval; }
        }

        public override bool RequiresQuestionAndAnswer
        {
            get { return requiresQuestionAndAnswer; }
        }

        public override bool RequiresUniqueEmail
        {
            get { return requiresUniqueEmail; }
        }

        public override int MaxInvalidPasswordAttempts
        {
            get { return maxInvalidPasswordAttempts; }
        }

        public override int PasswordAttemptWindow
        {
            get { return passwordAttemptWindow; }
        }

        public override int MinRequiredPasswordLength
        {
            get { return minRequiredPasswordLength; }
        }

        public override int MinRequiredNonAlphanumericCharacters
        {
            get { return minRequiredNonalphanumericCharacters; }
        }

        public override string PasswordStrengthRegularExpression
        {
            get { return passwordStrengthRegularExpression; }
        }

        public override MembershipPasswordFormat PasswordFormat
        {
            get { return passwordFormat; }
        }
        #endregion

        #region function
        public override void Initialize(string name, NameValueCollection config)
        {
            if (config == null)
            {
                throw new ArgumentNullException("config");
            }

            if (string.IsNullOrEmpty(name))
            {
                name = "MembershipProviderIml";
            }

            if (string.IsNullOrEmpty(config["description"]))
            {
                config.Remove("description");
                config.Add("description", "Implement Membership Provider");
            }

            base.Initialize(name, config);

            try
            {
                applicationName = GetConfigValue(config["applicationName"], System.Web.Hosting.HostingEnvironment.ApplicationVirtualPath);
                enablePasswordReset = Convert.ToBoolean(GetConfigValue(config["enablePasswordReset"], "true"));
                enablePasswordRetrieval = false;
                requiresQuestionAndAnswer = false;
                requiresUniqueEmail = true;
                maxInvalidPasswordAttempts = Convert.ToInt32(GetConfigValue(config["maxInvalidPasswordAttempts"], "5"));
                passwordAttemptWindow = Convert.ToInt32(GetConfigValue(config["passwordAttemptWindow"], "10"));
                minRequiredPasswordLength = Convert.ToInt32(GetConfigValue(config["minRequiredPasswordLength"], "6"));
                minRequiredNonalphanumericCharacters = Convert.ToInt32(GetConfigValue(config["minRequiredNonalphanumericCharacters"], "1"));
                passwordStrengthRegularExpression = Convert.ToString(GetConfigValue(config["passwordStrengthRegularExpression"], ""));
                passwordFormat = MembershipPasswordFormat.Hashed;

                Configuration webConfig = WebConfigurationManager.OpenWebConfiguration(System.Web.Hosting.HostingEnvironment.ApplicationVirtualPath);
                machineKey = (MachineKeySection) webConfig.GetSection("system.web/machineKey");
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override bool ChangePassword(string username, string oldPassword, string newPassword)
        {
            if (!ValidateUser(username, oldPassword))
            {
                return false;
            }

            ValidatePasswordEventArgs args = new ValidatePasswordEventArgs(username, newPassword, true);
            OnValidatingPassword(args);

            if (args.Cancel)
            {
                if (args.FailureInformation != null)
                {
                    throw args.FailureInformation;
                }
                else
                {
                    throw new MembershipPasswordException("Change password canceled due to new password validation failure.");
                }
            }

            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                db.Users.Single(m => m.Username.ToLower().Equals(username.ToLower())).Password = EncodePassword(newPassword);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool ChangePasswordAdmin(string username, string newPassword)
        {
            ValidatePasswordEventArgs args = new ValidatePasswordEventArgs(username, newPassword, true);
            OnValidatingPassword(args);

            if (args.Cancel)
            {
                if (args.FailureInformation != null)
                {
                    throw args.FailureInformation;
                }
                else
                {
                    throw new MembershipPasswordException("Change password canceled due to new password validation failure.");
                }
            }

            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                db.Users.Single(m => m.Username.ToLower().Equals(username.ToLower())).Password = EncodePassword(newPassword);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override bool ChangePasswordQuestionAndAnswer(string username, string password, string newPasswordQuestion, string newPasswordAnswer)
        {
            return false;
        }

        public override MembershipUser CreateUser(string username, string password, string email, string passwordQuestion, string passwordAnswer, bool isApproved, object providerUserKey, out MembershipCreateStatus status)
        {
            ValidatePasswordEventArgs args = new ValidatePasswordEventArgs(username, password, true);
            OnValidatingPassword(args);
            
            if (args.Cancel)
            {
                status = MembershipCreateStatus.InvalidPassword;
                return null;
            }

            if (RequiresUniqueEmail && !string.IsNullOrEmpty(GetUserNameByEmail(email)))
            {
                status = MembershipCreateStatus.DuplicateEmail;
                return null;
            }

            MembershipUser u = GetUser(username, false);

            if (u == null)
            {
                try
                {
                    QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                    User user = new User();

                    user.Username = username;
                    user.Password = EncodePassword(password);
                    user.Email = email;
                    user.PasswordQuestion = string.Empty;
                    user.Comment = string.Empty;
                    user.IsApproved = true;
                    user.IsLockedOut = false;
                    user.CreationDate = DateTime.Now;
                    user.LastPasswordChangedDate = DateTime.Now;
                    user.LastLoginDate = DateTime.Now;
                    user.LastLockoutDate = DateTime.Now;
                    user.LastActivityDate = DateTime.Now;

                    db.Users.AddObject(user);
                    db.SaveChanges();

                    status = MembershipCreateStatus.Success;
                    return GetUser(username, false);
                }
                catch
                {
                    status = MembershipCreateStatus.ProviderError;
                }
            }
            else
            {
                status = MembershipCreateStatus.DuplicateUserName;
            }
            return null;
        }
        
        public override bool DeleteUser(string username, bool deleteAllRelatedData)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                User user = db.Users.Single(m => m.Username.ToLower().Equals(username.ToLower()));
                db.Users.DeleteObject(user);
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override MembershipUserCollection GetAllUsers(int pageIndex, int pageSize, out int totalRecords)
        {
            MembershipUserCollection users = new MembershipUserCollection();
            totalRecords = 0;
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                totalRecords = db.Users.Count();
                if (totalRecords <= 0)
                {
                    return users;
                }

                foreach (var user in db.Users.OrderBy(m => m.Username).Skip(pageIndex * pageSize).Take(pageSize))
                {
                    users.Add(GetMembershipUserFromModel(user));
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return users;
        }

        public override int GetNumberOfUsersOnline()
        {
            return 0;
        }

        public override string GetPassword(string username, string answer)
        {
            return string.Empty;
        }

        public override MembershipUser GetUser(string username, bool userIsOnline)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                User user = db.Users.Single(m => m.Username.ToLower().Equals(username.ToLower()));
                return GetMembershipUserFromModel(user);
            }
            catch
            {
                return null;
            }
        }

        public override MembershipUser GetUser(object providerUserKey, bool userIsOnline)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                User user = db.Users.Single(m => m.Id == int.Parse(providerUserKey.ToString()));
                return GetMembershipUserFromModel(user);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override bool UnlockUser(string userName)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                db.Users.Single(m => m.Username.ToLower().Equals(userName.ToLower())).IsLockedOut = false;
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override string GetUserNameByEmail(string email)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                return db.Users.Single(m => m.Email.ToLower().Equals(email.ToLower())).Username;
            }
            catch
            {
                return string.Empty;
            }
        }

        public override string ResetPassword(string username, string answer)
        {
            if (!enablePasswordReset)
            {
                throw new NotSupportedException("Password reset is not enabled.");
            }

            string newPassword = Membership.GeneratePassword(MinRequiredPasswordLength, MinRequiredNonAlphanumericCharacters);

            ValidatePasswordEventArgs args = new ValidatePasswordEventArgs(username, newPassword, true);

            OnValidatingPassword(args);

            if (args.Cancel)
            {
                if (args.FailureInformation != null)
                {
                    throw args.FailureInformation;
                }
                else
                {
                    throw new MembershipPasswordException("Reset password canceled due to password validation failure.");
                }
            }

            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                db.Users.Single(m => m.Username.ToLower() == username.ToLower()).Password = EncodePassword(newPassword);
                db.SaveChanges();
                return newPassword;
            }
            catch
            {
                throw new MembershipPasswordException("User not found, or user is locked out. Password not Reset.");
            }
        }

        public override void UpdateUser(MembershipUser user)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                User updatedUser = db.Users.Single(m => m.Id == int.Parse(user.ProviderUserKey.ToString()));

                updatedUser.Username = user.UserName;
                updatedUser.Email = user.Email;
                updatedUser.PasswordQuestion = user.PasswordQuestion;
                updatedUser.Comment = user.Comment;

                db.SaveChanges();
            }
            catch
            {
                throw new MembershipPasswordException("User not found, or user is locked out. Password not Reset.");
            }
        }

        public override bool ValidateUser(string username, string password)
        {
            try
            {
                QuanLyDoDacEntities db = new QuanLyDoDacEntities();
                User user = db.Users.Single(m => m.Username.ToLower().Equals(username.ToLower()));

                if (user.IsApproved && user.IsLockedOut && CheckPassword(password, user.Password))
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public override MembershipUserCollection FindUsersByEmail(string emailToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        public override MembershipUserCollection FindUsersByName(string usernameToMatch, int pageIndex, int pageSize, out int totalRecords)
        {
            throw new NotImplementedException();
        }

        private MembershipUser GetMembershipUserFromModel(User user)
        {
            DateTime lastLoginDate = DateTime.Now;
            DateTime lastActivityDate = DateTime.Now;
            DateTime lastPasswordChangedDate = DateTime.Now;
            DateTime lastLockoutDate = DateTime.Now;
            if (user.LastLoginDate != null && user.LastLoginDate.HasValue)
            {
                lastLoginDate = user.LastLoginDate.Value;
            }
            if (user.LastActivityDate != null && user.LastActivityDate.HasValue)
            {
                lastActivityDate = user.LastActivityDate.Value;
            }
            if (user.LastPasswordChangedDate != null && user.LastPasswordChangedDate.HasValue)
            {
                lastPasswordChangedDate = user.LastPasswordChangedDate.Value;
            }
            if (user.LastLockoutDate != null && user.LastLockoutDate.HasValue)
            {
                lastLockoutDate = user.LastLockoutDate.Value;
            }

            return new MembershipUser(Name,
                user.Username, user.Id, user.Email, user.PasswordQuestion, user.Comment, user.IsApproved, user.IsLockedOut,
                user.CreationDate, lastLoginDate, lastActivityDate, lastPasswordChangedDate, lastLockoutDate);
        }

        private string GetConfigValue(string configValue, string defaultValue)
        {
            if (string.IsNullOrEmpty(configValue))
            {
                return defaultValue.Trim();
            }

            return configValue.Trim();
        }

        private bool CheckPassword(string password, string dbpassword)
        {
            if (EncodePassword(password) == dbpassword)
                return true;
            
            return false;
        }

        public string EncodePassword(string password)
        {
            string encodedPassword = password;

            HMACSHA1 hash = new HMACSHA1();
            hash.Key = HexToByte(machineKey.ValidationKey);
            encodedPassword = Convert.ToBase64String(hash.ComputeHash(Encoding.Unicode.GetBytes(password)));

            return encodedPassword;
        }

        private byte[] HexToByte(string hexString)
        {
            byte[] returnBytes = new byte[hexString.Length / 2];

            for (int i = 0; i < returnBytes.Length; i++)
            {
                returnBytes[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);
            }

            return returnBytes;
        }
        #endregion
    }
}