module Fastlane
  module Actions
    module SharedValues
      GIT_REMOVE_TAG_CUSTOM_VALUE = :GIT_REMOVE_TAG_CUSTOM_VALUE
    end

    class GitRemoveTagAction < Action
      def self.run(params)
        # fastlane will take care of reading in the parameter and fetching the environment variable:


        # sh "shellcommand ./path"

        # Actions.lane_context[SharedValues::GIT_REMOVE_TAG_CUSTOM_VALUE] = "my_val"
        # get tag name
        tag = params[:tag]
        
    
        cmds = []
        
        isRemoveLocalTag = params[:rLocal]
        
        isRemoveRemoteTag = params[:rRemote]
        
        if isRemoveLocalTag
        cmds << "git tag -d #{tag}"
        end
    
        if isRemoveLocalTag
        
        cmds << "git push origin :#{tag}"
        
        end
  
        Actions.sh(cmds.join(' & '))

    
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "remove loacl or remote tag"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "remove local tag or remove remote tag"
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [

            FastlaneCore::ConfigItem.new(key: :tag,
                                         description: " tag name ",
                                         optional: false,
                                         is_string: true),

            FastlaneCore::ConfigItem.new(key: :rLocal,
                                         description: " is remove the local tag ? ",
                                         optional: true,
                                         is_string: false,
                                         default_value: true),

            FastlaneCore::ConfigItem.new(key: :rRemote,
                                         description: " is remove the remote tag ? ",
                                         optional: true,
                                         is_string: false,
                                         default_value: true)
        ]
      end

      def self.output
        # Define the shared values you are going to provide

      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
        nil
      end

      def self.authors
        # So no one will ever forget your contribution to fastlane :) You are awesome btw!
        ["iCorki"]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :ios
      end
    end
  end
end
