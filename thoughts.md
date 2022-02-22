## Next Steps

Upon completion, briefly outline the next few steps you would plan to take to complete the entire feature spec.

* I have to get API access for the various social media platforms such that the Item content will be published directly on those platforms.
* I will limit users to be able to only add social media of the platforms for which we have API access to avoid future errors.
* Add validation messages such that the same content shouldn't exist for the same social_network.
* I will add automatic publishing of content to social media based on publish_date.
* I will add recursive publishing of content such that the same content will sequentially be published based on the specified time.
* Get a good design for the application.
* Enable users to create content from google docs using API.
* Subscription plan based on the number of content published per month.
* Create an audience role for users so that they subscribe to authors who publish content.

## Bugs and Issues

* No bugs
* I would love to dig deep on how to simplify the code that creates content and publish date on the same request. I think my current implementation is a little bit complex.

## Thoughts and Comments
* The idea of adding the publish_date to the publishing_target table is a very good one as it brings more flexibility in the manipulation of data.

