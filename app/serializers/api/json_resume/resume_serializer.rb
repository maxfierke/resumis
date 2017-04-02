module Api
  module JsonResume
    class ResumeSerializer < ActiveModel::Serializer
      include ApplicationHelper

      attributes :basics, :work, :volunteer, :education, :awards, :publications,
                 :skills, :languages, :interests, :references

      def basics
        {
          name: user.full_name,
          label: user.tagline,
          picture: user.avatar_url,
          email: user.email,
          phone: '', # TODO: Phone
          website: "https://#{tenant_instance_hostname(user)}",
          summary: resume.background,
          location: location,
          profiles: profiles
        }
      end

      def work
        work_experiences.map do |work_exp|
          {
            company: work_exp.organization,
            position: work_exp.position,
            website: "", # TODO: Work Experience Website
            startDate: work_exp.start_date,
            endDate: work_exp.end_date,
            summary: work_exp.description,
            highlights: [] # TODO: Work Experience highlights
          }
        end
      end

      def education
        education_experiences.map do |edu|
          {
            institution: edu.school_name,
            area: '', # TODO: Seperate area from diploma
            studyType: edu.diploma,
            startDate: edu.start_date,
            endDate: edu.end_date,
            gpa: '', # TODO: Add GPA
            courses: [] # TODO: Add courses
          }
        end
      end

      def volunteer
        volunteer_experiences.map do |volunteer|
          {
            company: volunteer.organization,
            position: volunteer.position,
            website: "", # TODO: Volunteer Experience Website
            startDate: volunteer.start_date,
            endDate: volunteer.end_date,
            summary: volunteer.description,
            highlights: [] # TODO: Volunteer Experience highlights
          }
        end
      end

      def awards
        []
        # TODO: Awards
        # object.awards.map do |award|
        #   {
        #     title: award.title,
        #     date: award.date,
        #     awarder: award.awarder,
        #     summary: award.description
        #   }
        # end
      end

      def publications
        []
        # TODO: Publications
        # object.publications do |publication|
        #   {
        #     name: publication.name,
        #     publisher: publication.publisher,
        #     releaseDate: publication.publish_date,
        #     website: publication.website,
        #     summary: publication.description
        #   }
        # end
      end

      def skills
        resume.skills.group_by do |skill|
          skill.skill_category.name
        end.map do |category, skills|
          {
            name: category,
            level: "", # TODO: Implement levels
            keywords: skills.map { |skill| skill.name }
          }
        end
      end

      def languages
        []
        # TODO: Lanaguages
        # object.languages do |lang|
        #   {
        #     name: lang.name,
        #     level: lang.proficency
        #   }
        # end
      end

      def interests
        []
        # TODO: Interests
      end

      def references
        []
      end

      private

      def location
        # TODO: Location
        { 
          address: "",
          postalCode: "",
          city: "",
          countryCode: "",
          region: ""
        }
      end

      def profiles
        user_profiles = []
        user_profiles << {
          network: "Twitter",
          username: user.twitter_handle,
          url: "https://twitter.com/#{user.twitter_handle}"
        } if user.twitter_handle
        user_profiles << {
          network: "LinkedIn",
          username: user.linkedin_handle,
          url: "https://linkedin.com/in/#{user.linkedin_handle}"
        } if user.linkedin_handle
        user_profiles << {
          network: "GitHub",
          username: user.github_handle,
          url: "https://github.com/#{user.github_handle}"
        } if user.github_handle
        user_profiles
      end

      def work_experiences
        object.work_experiences
      end

      def education_experiences
        object.education_experiences
      end

      def volunteer_experiences
        [] # TODO: Volunteer experiences
      end

      def resume
        object
      end

      def user
        object.user
      end
    end
  end
end
